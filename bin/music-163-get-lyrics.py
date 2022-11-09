#!/usr/bin/env python3
from urllib.request import Request, urlopen
import json
import sys
import os

class song:
    song_id = 0
    name = ''
    album = ''
    artist = ''
    lyrics = ''
    tlyrics = ''
    msg = ''
    lyrics_flag = 2 #0: both found
                    #1: lyrics not found
                    #2: translation not found
                    #3: instrumental - no lyrics
    song_found = 0  #0: song not found
                    #1: song found

    def file_name(self):
        return self.artist + ' - ' + self.name

    def get_song_info(self):
        info_url = 'http://music.163.com/api/song/detail?ids=[' + str(self.song_id) + ']'
        req = Request(info_url)
        req.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0'
        }
        response = urlopen(req)
        data = json.loads(response.read().decode('utf-8'))
        try:
            self.name = data['songs'][0]['name']
            self.album = data['songs'][0]['album']['name']
            self.artist = data['songs'][0]['artists'][0]['name']
            self.song_found = 1
        except Exception as e:
            self.song_found = 0

    def get_lyrics(self):
        lyrics_url = 'http://music.163.com/api/song/lyric?lv=-1&tv=-1&id=' + str(self.song_id)
        req = Request(lyrics_url)
        req.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0'
        }
        response = urlopen(req)
        data = json.loads(response.read().decode('utf-8'))
        if 'nolyrics' in data:
            self.lyrics_flag = 3
            return 0
        try:
            if data['lrc']['lyric'] != None:
                self.lyrics = data['lrc']['lyric']
            else:
                self.lyrics_flag = 1
        except:
            self.lyrics_flag = 1
            return 0
        try:
            if data['tlyric']['lyric'] != None:
                self.tlyrics = data['tlyric']['lyric']
                self.lyrics_flag = 0
            else:
                self.lyrics_flag = 2
        except:
            self.lyrics_flag = 2
            return 0

    def get_msg(self):
        if self.song_found == 0:
            self.msg = 'Song not found.'
            return 0
        else:
            self.msg = 'Song found. '
        if self.lyrics_flag == 1:
            self.msg += 'No one has uploaded the lyrics.'
        elif self.lyrics_flag == 2:
            self.msg += 'No one has translated the lyrics.'
        elif self.lyrics_flag == 3:
            self.msg += 'Instrumental music - does not have lyrics.'

    def get_all_song_info(self):
        self.get_song_info()
        if self.song_found == 1: self.get_lyrics()
        self.get_msg()

    def dump(self):
        dump_string = ''
        if self.song_found == 0:
            dump_string += self.msg
            return dump_string
        else:
            dump_string += self.name + ' - ' + self.artist + ' - ' + self.album

        if self.lyrics_flag == 0:
            dump_string += '\n\n' + self.lyrics + '\n\n' + self.tlyrics + '\n\n' + self.msg
        elif self.lyrics_flag == 1 or self.lyrics_flag == 3:
            dump_string += '\n\n' + self.msg
        elif self.lyrics_flag == 2:
            dump_string += '\n\n' + self.lyrics + '\n\n' + self.msg

        return dump_string

### main program ###
def main():
    if len(sys.argv) < 2:
        exitChar = ''
        while exitChar != 'e':
            print('\n—— Get lyrics from NetEase Cloud Music (music.163.com) ——\n')

            x = song()
            x.song_id = input('Please enter song ID: ')
            
            x.get_all_song_info()
            print('\n' + x.dump())

            if x.lyrics != '':
                save_lrc = input('\nWould you like to save lyrics to .lrc file? Y for \'yes\', else for \'no\': ')
                if save_lrc in ['Y', 'y']:
                    lrc_file_name = x.file_name() + '.lrc'
                    with open(lrc_file_name, 'w') as lrc_file:
                        lrc_file.write(x.lyrics)
                        print(f'Lyrics saved to: {lrc_file_name}')
                else:
                    print('Lyrics not saved')

            exitChar = input('\nEnter e to exit, or else to continue: ')
    else:
        x = song()
        x.song_id = sys.argv[1]
        x.get_all_song_info()

        if x.lyrics != '':
            lrc_file_name = sys.argv[2] + ' - ' + sys.argv[3] + '.lrcx'
            lrc_file_name = lrc_file_name.replace('/', ':')
            with open(lrc_file_name, 'w') as lrc_file:
                lrc_file.write(x.lyrics)
                print(f'Lyrics saved to: {lrc_file_name}')

if __name__ == '__main__':
    main()

