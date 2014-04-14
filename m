From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Driver CH341 USB Adapter Serial Port not Works in Linux
Date: Sun, 13 Apr 2014 22:23:23 -0700
Message-ID: <20140414052323.GB11480@kroah.com>
References: <CAMkwOQZXVQkQsLfbvZFKSLeqbYJZVVdRUDXT+UYe6As4NTtrMA@mail.gmail.com>
 <20140414012013.GA1882@kroah.com>
 <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q@mail.gmail.com>
 <20140414014410.GA5136@kroah.com>
 <CAMkwOQaqQgDzE430u3TOG85gtqrX-AK0nTWK9dYsJSk-JtK5Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43309 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaDNFU2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2014 01:20:28 -0400
Content-Disposition: inline
In-Reply-To: <CAMkwOQaqQgDzE430u3TOG85gtqrX-AK0nTWK9dYsJSk-JtK5Mg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kijam =?iso-8859-1?Q?L=F3pez?= <kijamve@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Apr 14, 2014 at 12:16:40AM -0430, Kijam L=F3pez wrote:
> I reported here:
>=20
>      https://bugreports.qt-project.org/browse/QTBUG-38305
>=20
> But just migrate my APP to ANSI C and is exactly the same.
>=20
> My code test in ANSI C:
>=20
>      #include <sys/types.h>
>      #include <sys/stat.h>
>      #include <fcntl.h>
>      #include <termios.h>
>      #include <unistd.h>
>      #include <errno.h>
>      #include <stdio.h>
>      #include <string.h>
>      #include <ctype.h>
>      #include <pthread.h>
>      #include <stdlib.h>
>      #include <time.h>
>=20
>      #define STX (0x02)
>      #define ETX (0x03)
>      #define ENQ (0x05)
>      #define ACK (0x06)
>      #define NAK (0x15)
>      #define SEP (0x0A)
>=20
>      int serial =3D -1;
>      int finnish =3D 0;
>=20
>      char *buffer =3D NULL;
>      size_t buffer_size =3D 0;
>      size_t buffer_len =3D 0;
>=20
>      const char enq[1] =3D {ENQ};
>      const char ack[1] =3D {ACK};
>      const char nak[1] =3D {NAK};
>=20
>      pthread_cond_t buffer_no_empty =3D PTHREAD_COND_INITIALIZER;
>      pthread_mutex_t buffer_mutex =3D PTHREAD_MUTEX_INITIALIZER;
>=20
>      static void debug_str(const char *str, size_t size) {
>           int i;
>           for(i =3D 0; i < size; ++i)
>                if(isprint(str[i]) && !iscntrl(str[i]))
>                     printf("%c", (char)str[i]);
>                else
>                     printf(" 0x%02X ", (unsigned char) str[i]);
>           printf("\n");
>      }
>=20
>      static void flush() {
>           if(serial<0) return;
>           tcflush(serial, TCIFLUSH);
>           tcflush(serial, TCIOFLUSH);
>           tcflush(serial, TCOFLUSH);
>      }
>=20
>      static void openPort(const char *port) {
>           serial =3D open(port, O_RDWR | O_NOCTTY | O_NONBLOCK);
>           if(serial<0) {
>                printf("Error %u from serial open: %s\n", errno,
> strerror(errno));
>                return ;
>           }
>=20
>           struct termios tty;
>           memset(&tty, 0, sizeof(tty));
>=20
>           // Set Baud Rate
>           cfsetospeed (&tty, B9600);
>           cfsetispeed (&tty, B9600);
>=20
>           tty.c_cflag     |=3D   PARENB;
>           tty.c_cflag     &=3D   ~(PARODD | CSTOPB | CSIZE);
>           tty.c_cflag     |=3D   CS8;
>           tty.c_cflag     |=3D   CLOCAL;
>           tty.c_cflag     |=3D   CREAD;
>=20
>           tty.c_iflag |=3D (IXON | IXOFF | IXANY);
>=20
>           flush();
>=20
>           if ( tcsetattr(serial, TCSANOW, &tty) !=3D 0 )
>                printf("Error %d from tcsetattr: %s\n", errno, strerro=
r(errno));
>=20
>           flush();
>      }
>=20
>      #define valid_buffer() (buffer_size>3 && buffer[0]=3D=3DSTX &&
> buffer[buffer_size-2] =3D=3D ETX)
>=20
>      static void* thread_read(void* dummy) {
>           unsigned char buf;
>           while(!finnish) {
>                int n =3D read(serial, &buf, 1);
>                if(n>0) {
>                     pthread_mutex_lock(&buffer_mutex);
>                     if(buf =3D=3D ENQ) {
>                          printf("Recive ENQ, sending ACK\n");
>                          write(serial, ack, 1);
>                          pthread_mutex_unlock(&buffer_mutex);
>                          continue;
>                     }
>                     if(buffer_size =3D=3D buffer_len) {
>                          buffer_len *=3D 2;
>                          buffer =3D realloc(buffer, (size_t)buffer_le=
n);
>                     }
>                     buffer[buffer_size] =3D buf;
>                     buffer_size +=3D 1;
>                     printf("Buffer: ");
>                     debug_str(buffer, buffer_size);
>                     if(valid_buffer()) {
>                          printf("Signal buffer_no_empty\n");
>                          pthread_cond_signal(&buffer_no_empty);
>                     }
>                     pthread_mutex_unlock(&buffer_mutex);
>                }else if(n<0 && errno!=3D11) {
>                     printf("Error %d from serial read: %s\n", errno,
> strerror(errno));
>                }
>           }
>           return NULL;
>      }
>=20
>      static void send_and_read(const char *data, size_t size, int
> timeout, char **recv, size_t *size_recv) {
>=20
>           printf("Write: ");
>           debug_str(data, size);
>=20
>           write(serial, data, size);
>=20
>           time_t startTime =3D time(NULL);
>           struct timespec ts;
>           clock_gettime(CLOCK_REALTIME, &ts);
>           ts.tv_sec +=3D timeout;
>=20
>           printf("Wait response...\n");
>           pthread_mutex_lock(&buffer_mutex);
>=20
>           while(!valid_buffer() && time(NULL)-startTime<timeout-1)
>                pthread_cond_timedwait(&buffer_no_empty, &buffer_mutex=
, &ts);
>=20
>           if(valid_buffer()) {
>                *recv =3D malloc(buffer_size+1);
>                *size_recv =3D buffer_size;
>                memcpy(*recv, buffer, buffer_size);
>                (*recv)[buffer_size]=3D'\0';
>                printf("Read:");
>                debug_str(*recv, buffer_size);
>           }else{
>                printf("Timeout...\n");
>                *recv =3D NULL;
>                *size_recv =3D 0;
>           }
>           buffer_size =3D 0;
>           memset(buffer, 0, buffer_len);
>=20
>           pthread_mutex_unlock(&buffer_mutex);
>      }
>=20
>      int main(){
>           openPort("/dev/ttyUSB0");
>           if(serial>0) {
>                buffer =3D malloc(1024);
>                buffer_len =3D 1024;
>                pthread_t thread;
>                pthread_create(&thread, NULL, thread_read, NULL);
>=20
>                char *test =3D NULL;
>                size_t s =3D 0;
>                send_and_read(enq, 1, 15, &test, &s);
>                if(s>0)
>                     printf("Test status: OK\n");
>                else
>                     printf("Test status: Fail\n");
>=20
>                sleep(3); //Pause...
>=20
>                char command[5] =3D {STX, 'S', '1', ETX, 'a'};
>=20
>                send_and_read(command, 5, 15, &test, &s);
>                if(s>0)
>                     printf("Test command: OK\n");
>                else
>                     printf("Test command: Fail\n");
>=20
>                finnish =3D 1;
>=20
>                void *dummy;
>                pthread_join(thread, &dummy);
>=20
>                close(serial);
>                free(buffer);
>           }
>      }
>=20
> My Log of APP:
>      Write:  0x05
>      Wait response...
>      Buffer:  0x02
>      Buffer:  0x02 `
>      Buffer:  0x02 `@
>      Buffer:  0x02 `@ 0x03
>      Buffer:  0x02 `@ 0x03 #
>      Signal buffer_no_empty
>      Read: 0x02 `@ 0x03 #
>      Test status: OK
>      Write:  0x02 S1 0x03 a
>      Wait response...
>      Timeout...
>      Test command: Fail

I'm confused, what should it do?

And what kernel version are you using here?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
