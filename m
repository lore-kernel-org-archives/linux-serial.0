From: =?ISO-8859-1?Q?Kijam_L=F3pez?= <kijamve@gmail.com>
Subject: Re: Driver CH341 USB Adapter Serial Port not Works in Linux
Date: Mon, 14 Apr 2014 00:16:40 -0430
Message-ID: <CAMkwOQaqQgDzE430u3TOG85gtqrX-AK0nTWK9dYsJSk-JtK5Mg@mail.gmail.com>
References: <CAMkwOQZXVQkQsLfbvZFKSLeqbYJZVVdRUDXT+UYe6As4NTtrMA@mail.gmail.com>
 <20140414012013.GA1882@kroah.com> <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q@mail.gmail.com>
 <20140414014410.GA5136@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:60167 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaDNErB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2014 00:47:01 -0400
In-Reply-To: <20140414014410.GA5136@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

I reported here:

     https://bugreports.qt-project.org/browse/QTBUG-38305

But just migrate my APP to ANSI C and is exactly the same.

My code test in ANSI C:

     #include <sys/types.h>
     #include <sys/stat.h>
     #include <fcntl.h>
     #include <termios.h>
     #include <unistd.h>
     #include <errno.h>
     #include <stdio.h>
     #include <string.h>
     #include <ctype.h>
     #include <pthread.h>
     #include <stdlib.h>
     #include <time.h>

     #define STX (0x02)
     #define ETX (0x03)
     #define ENQ (0x05)
     #define ACK (0x06)
     #define NAK (0x15)
     #define SEP (0x0A)

     int serial =3D -1;
     int finnish =3D 0;

     char *buffer =3D NULL;
     size_t buffer_size =3D 0;
     size_t buffer_len =3D 0;

     const char enq[1] =3D {ENQ};
     const char ack[1] =3D {ACK};
     const char nak[1] =3D {NAK};

     pthread_cond_t buffer_no_empty =3D PTHREAD_COND_INITIALIZER;
     pthread_mutex_t buffer_mutex =3D PTHREAD_MUTEX_INITIALIZER;

     static void debug_str(const char *str, size_t size) {
          int i;
          for(i =3D 0; i < size; ++i)
               if(isprint(str[i]) && !iscntrl(str[i]))
                    printf("%c", (char)str[i]);
               else
                    printf(" 0x%02X ", (unsigned char) str[i]);
          printf("\n");
     }

     static void flush() {
          if(serial<0) return;
          tcflush(serial, TCIFLUSH);
          tcflush(serial, TCIOFLUSH);
          tcflush(serial, TCOFLUSH);
     }

     static void openPort(const char *port) {
          serial =3D open(port, O_RDWR | O_NOCTTY | O_NONBLOCK);
          if(serial<0) {
               printf("Error %u from serial open: %s\n", errno,
strerror(errno));
               return ;
          }

          struct termios tty;
          memset(&tty, 0, sizeof(tty));

          // Set Baud Rate
          cfsetospeed (&tty, B9600);
          cfsetispeed (&tty, B9600);

          tty.c_cflag     |=3D   PARENB;
          tty.c_cflag     &=3D   ~(PARODD | CSTOPB | CSIZE);
          tty.c_cflag     |=3D   CS8;
          tty.c_cflag     |=3D   CLOCAL;
          tty.c_cflag     |=3D   CREAD;

          tty.c_iflag |=3D (IXON | IXOFF | IXANY);

          flush();

          if ( tcsetattr(serial, TCSANOW, &tty) !=3D 0 )
               printf("Error %d from tcsetattr: %s\n", errno, strerror(=
errno));

          flush();
     }

     #define valid_buffer() (buffer_size>3 && buffer[0]=3D=3DSTX &&
buffer[buffer_size-2] =3D=3D ETX)

     static void* thread_read(void* dummy) {
          unsigned char buf;
          while(!finnish) {
               int n =3D read(serial, &buf, 1);
               if(n>0) {
                    pthread_mutex_lock(&buffer_mutex);
                    if(buf =3D=3D ENQ) {
                         printf("Recive ENQ, sending ACK\n");
                         write(serial, ack, 1);
                         pthread_mutex_unlock(&buffer_mutex);
                         continue;
                    }
                    if(buffer_size =3D=3D buffer_len) {
                         buffer_len *=3D 2;
                         buffer =3D realloc(buffer, (size_t)buffer_len)=
;
                    }
                    buffer[buffer_size] =3D buf;
                    buffer_size +=3D 1;
                    printf("Buffer: ");
                    debug_str(buffer, buffer_size);
                    if(valid_buffer()) {
                         printf("Signal buffer_no_empty\n");
                         pthread_cond_signal(&buffer_no_empty);
                    }
                    pthread_mutex_unlock(&buffer_mutex);
               }else if(n<0 && errno!=3D11) {
                    printf("Error %d from serial read: %s\n", errno,
strerror(errno));
               }
          }
          return NULL;
     }

     static void send_and_read(const char *data, size_t size, int
timeout, char **recv, size_t *size_recv) {

          printf("Write: ");
          debug_str(data, size);

          write(serial, data, size);

          time_t startTime =3D time(NULL);
          struct timespec ts;
          clock_gettime(CLOCK_REALTIME, &ts);
          ts.tv_sec +=3D timeout;

          printf("Wait response...\n");
          pthread_mutex_lock(&buffer_mutex);

          while(!valid_buffer() && time(NULL)-startTime<timeout-1)
               pthread_cond_timedwait(&buffer_no_empty, &buffer_mutex, =
&ts);

          if(valid_buffer()) {
               *recv =3D malloc(buffer_size+1);
               *size_recv =3D buffer_size;
               memcpy(*recv, buffer, buffer_size);
               (*recv)[buffer_size]=3D'\0';
               printf("Read:");
               debug_str(*recv, buffer_size);
          }else{
               printf("Timeout...\n");
               *recv =3D NULL;
               *size_recv =3D 0;
          }
          buffer_size =3D 0;
          memset(buffer, 0, buffer_len);

          pthread_mutex_unlock(&buffer_mutex);
     }

     int main(){
          openPort("/dev/ttyUSB0");
          if(serial>0) {
               buffer =3D malloc(1024);
               buffer_len =3D 1024;
               pthread_t thread;
               pthread_create(&thread, NULL, thread_read, NULL);

               char *test =3D NULL;
               size_t s =3D 0;
               send_and_read(enq, 1, 15, &test, &s);
               if(s>0)
                    printf("Test status: OK\n");
               else
                    printf("Test status: Fail\n");

               sleep(3); //Pause...

               char command[5] =3D {STX, 'S', '1', ETX, 'a'};

               send_and_read(command, 5, 15, &test, &s);
               if(s>0)
                    printf("Test command: OK\n");
               else
                    printf("Test command: Fail\n");

               finnish =3D 1;

               void *dummy;
               pthread_join(thread, &dummy);

               close(serial);
               free(buffer);
          }
     }

My Log of APP:
     Write:  0x05
     Wait response...
     Buffer:  0x02
     Buffer:  0x02 `
     Buffer:  0x02 `@
     Buffer:  0x02 `@ 0x03
     Buffer:  0x02 `@ 0x03 #
     Signal buffer_no_empty
     Read: 0x02 `@ 0x03 #
     Test status: OK
     Write:  0x02 S1 0x03 a
     Wait response...
     Timeout...
     Test command: Fail


My syslog:

     Apr 14 00:09:44 kali kernel: [14827.112964] tty ttyUSB0: serial_op=
en
     Apr 14 00:09:44 kali kernel: [14827.112981] usb 1-1:
ch341_control_in(c0,5f,0000,0000,ef484b00,8)
     Apr 14 00:09:44 kali kernel: [14827.114572] usb 1-1:
ch341_control_out(40,a1,0000,0000)
     Apr 14 00:09:44 kali kernel: [14827.115557] usb 1-1:
ch341_control_out(40,9a,1312,b202)
     Apr 14 00:09:44 kali kernel: [14827.116592] usb 1-1:
ch341_control_out(40,9a,0f2c,000c)
     Apr 14 00:09:44 kali kernel: [14827.117595] usb 1-1:
ch341_control_in(c0,95,2518,0000,ef484b00,8)
     Apr 14 00:09:44 kali kernel: [14827.118579] usb 1-1:
ch341_control_out(40,9a,2518,0050)
     Apr 14 00:09:44 kali kernel: [14827.119572] usb 1-1:
ch341_control_in(c0,95,0706,0000,ef484a40,8)
     Apr 14 00:09:44 kali kernel: [14827.120608] usb 1-1:
ch341_control_out(40,a1,501f,d90a)
     Apr 14 00:09:44 kali kernel: [14827.121572] usb 1-1:
ch341_control_out(40,9a,1312,b202)
     Apr 14 00:09:44 kali kernel: [14827.122569] usb 1-1:
ch341_control_out(40,9a,0f2c,000c)
     Apr 14 00:09:44 kali kernel: [14827.123566] usb 1-1:
ch341_control_out(40,a4,ff9f,0000)
     Apr 14 00:09:44 kali kernel: [14827.124602] usb 1-1:
ch341_control_in(c0,95,0706,0000,ef484a40,8)
     Apr 14 00:09:44 kali kernel: [14827.125572] usb 1-1:
ch341_control_out(40,a4,ff9f,0000)
     Apr 14 00:09:44 kali kernel: [14827.126567] usb 1-1:
ch341_control_out(40,9a,1312,b202)
     Apr 14 00:09:44 kali kernel: [14827.127566] usb 1-1:
ch341_control_out(40,9a,0f2c,000c)
     Apr 14 00:09:44 kali kernel: [14827.128597] ch341-uart ttyUSB0:
ch341_open - submitting interrupt urb
     Apr 14 00:09:44 kali kernel: [14827.128649] usb 1-1:
ch341_control_out(40,a4,ff9f,0000)
     Apr 14 00:09:44 kali kernel: [14827.129658] tty ttyUSB0:
serial_ioctl - cmd 0x540b
     Apr 14 00:09:44 kali kernel: [14827.129678] tty ttyUSB0:
serial_ioctl - cmd 0x540b
     Apr 14 00:09:44 kali kernel: [14827.129691] tty ttyUSB0:
serial_ioctl - cmd 0x540b
     Apr 14 00:09:44 kali kernel: [14827.129706] tty ttyUSB0:
serial_ioctl - cmd 0x5401
     Apr 14 00:09:44 kali kernel: [14827.129720] tty ttyUSB0:
serial_ioctl - cmd 0x5402
     Apr 14 00:09:44 kali kernel: [14827.129733] tty ttyUSB0: serial_se=
t_termios
     Apr 14 00:09:44 kali kernel: [14827.129746] usb 1-1:
ch341_control_out(40,9a,1312,b202)
     Apr 14 00:09:44 kali kernel: [14827.130559] ch341-uart ttyUSB0:
ch341_update_line_status - multiple status change
     Apr 14 00:09:44 kali kernel: [14827.130570] ch341-uart ttyUSB0:
ch341_update_line_status - delta=3D0x02
     Apr 14 00:09:44 kali kernel: [14827.130612] usb 1-1:
ch341_control_out(40,9a,0f2c,000c)
     Apr 14 00:09:44 kali kernel: [14827.131589] usb 1-1:
ch341_control_out(40,a4,ff9f,0000)
     Apr 14 00:09:44 kali kernel: [14827.132553] ch341-uart ttyUSB0:
ch341_update_line_status - multiple status change
     Apr 14 00:09:44 kali kernel: [14827.132571] ch341-uart ttyUSB0:
ch341_update_line_status - delta=3D0x02
     Apr 14 00:09:44 kali kernel: [14827.133388] tty ttyUSB0:
serial_ioctl - cmd 0x5401
     Apr 14 00:09:44 kali kernel: [14827.133411] tty ttyUSB0:
serial_ioctl - cmd 0x540b
     Apr 14 00:09:44 kali kernel: [14827.133427] tty ttyUSB0:
serial_ioctl - cmd 0x540b
     Apr 14 00:09:44 kali kernel: [14827.133440] tty ttyUSB0:
serial_ioctl - cmd 0x540b
     Apr 14 00:09:44 kali kernel: [14827.134087] tty ttyUSB0:
serial_write - 1 byte(s)
     Apr 14 00:09:47 kali kernel: [14830.144091] tty ttyUSB0:
serial_write - 5 byte(s)
     Apr 14 00:09:47 kali kernel: [14830.152441] ch341-uart ttyUSB0:
ch341_update_line_status - multiple status change
     Apr 14 00:09:47 kali kernel: [14830.152452] ch341-uart ttyUSB0:
ch341_update_line_status - delta=3D0x01
     Apr 14 00:09:47 kali kernel: [14830.154426] ch341-uart ttyUSB0:
ch341_update_line_status - multiple status change
     Apr 14 00:09:47 kali kernel: [14830.154433] ch341-uart ttyUSB0:
ch341_update_line_status - delta=3D0x01
     Apr 14 00:10:02 kali kernel: [14845.144415] tty ttyUSB0: serial_cl=
ose
     Apr 14 00:10:02 kali kernel: [14845.144432] tty ttyUSB0:
serial_chars_in_buffer
     Apr 14 00:10:02 kali kernel: [14845.144442] tty ttyUSB0:
serial_wait_until_sent
     Apr 14 00:10:02 kali kernel: [14845.147914] usb 1-1:
ch341_read_int_callback - urb shutting down: -2
     Apr 14 00:10:02 kali kernel: [14845.149723] tty ttyUSB0: serial_cl=
eanup


I think it's not the fault of QT ...


2014-04-13 21:14 GMT-04:30 Greg KH <gregkh@linuxfoundation.org>:
> On Sun, Apr 13, 2014 at 08:51:56PM -0430, Kijam L=F3pez wrote:
>> The following code works for me correctly in Windows, but Linux does
>> not work. I am using the same PC, both operating systems are install=
ed
>> native. I do not use virtual machine. I need to work on Linux. I hav=
e
>> tried in different linux distributions and does not work anywhere.
>
> <snip>
>
> Sounds like a Qt issue, what is the status of the bug you filed with
> those developers?
>
> greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
