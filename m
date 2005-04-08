From: =?koi8-r?B?5M3J1NLJyg==?= <dmitry_b@list.ru>
Subject: pl2303 (HX chip) i/o trouble in raw mode
Date: Sat, 9 Apr 2005 00:14:55 +0400
Message-ID: <E1DJzsT-000GOf-00.dmitry_b-list-ru@mx2.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.mail.ru ([194.67.23.122]:3599 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262943AbVDHUOx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Apr 2005 16:14:53 -0400
Received: from [213.171.38.22] (port=1428 helo=morozstation)
	by mx2.mail.ru with esmtp
	id 1DJzsT-000GOf-00
	for linux-serial@vger.kernel.org; Sat, 09 Apr 2005 00:14:53 +0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello. I'm having great problems with  this device. I have to make it work
in a raw mode in order to communicate to CashCode Billvalidator. But a can't
write data in pl2303.

My /proc/bus/usb/devices is

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=067b ProdID=2303 Rev= 3.00
S:  Manufacturer=Prolific Technology Inc.
S:  Product=USB-Serial Controller
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=pl2303
E:  Ad=81(I) Atr=03(Int.) MxPS=  10 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms 

I tried to connect normal serial port (ttyS1) and Prolific device with
direct cable. My test program is: 

#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <strings.h>

int main(void){
   
   int fd1,fd2; 
   struct termios new_tio;
   char buf[10]="";
  
   fd1=  open("/dev/ttyS1",O_RDWR | O_NOCTTY);
   fd2=  open("/dev/ttyUSB0",O_RDWR | O_NOCTTY);

   bzero(&new_tio,sizeof(new_tio));
   
   new_tio.c_iflag  = IGNPAR;
   new_tio.c_oflag  = 0;
   new_tio.c_lflag  = 0;
   new_tio.c_cflag  = CRTSCTS | CS8 | CLOCAL | CREAD;   
   new_tio.c_cc[VTIME] = 0;
   new_tio.c_cc[VMIN] = 0;

   cfsetospeed(&new_tio, B19200);
   cfsetispeed(&new_tio, B19200);

   tcflush(fd1, TCIFLUSH);
   tcsetattr(fd1,TCSANOW,&new_tio);   
      
   tcflush(fd2, TCIFLUSH);
   tcsetattr(fd2,TCSANOW,&new_tio);   
   
   write(fd2, "Test\n",6);
   sleep(1);
   read(fd1,buf,6);

   printf("%s",buf);
   
   close(fd1);
   close(fd2);
  
   return 1;
}

1. When I try to send data from fd1 to fd2 I have very strange situation. In
the first time I receive "Test".... BUT!!!! In the second time "est" (T is
missing). At the third run every thing is normal. And so on. I lose first
character each second time.

2. When I try to send data from fd2 to fd1 (write to pl2303) I have more
strange situation.  can send "Test" only one time (at the first attempt)
after that I can run the program several times but nothing is received
UNTILL  I reattach the device.

My system is Slackware Linux 10.1 with 2.6.11.4 

Hope for your help.

