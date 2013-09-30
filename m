From: kees Schoenmakers <k.schoenmakers@sigmae.nl>
Subject: recent kernels [i.e. 3.10.12] shows serial driver problem
Date: Mon, 30 Sep 2013 08:23:57 +0200
Message-ID: <11144439.5yyClnqeWI@sepc002>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1801756.uQFXhvlc4z"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:2526 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab3I3GbK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Sep 2013 02:31:10 -0400
Received: from Mail01.rh.local (rhict.xs4all.nl [83.161.219.224])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id r8U6NwrB051342
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-serial@vger.kernel.org>; Mon, 30 Sep 2013 08:24:08 +0200 (CEST)
	(envelope-from k.schoenmakers@sigmae.nl)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.orglinux-serial@vger.kernel.org

--nextPart1801756.uQFXhvlc4z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"


Hello Friends,

I recently jumped from kernel 3.5.0 to 3.10.12
With the later kernel a modem application does no longer work.

I created a small test program which gives more information, it is attached as 
t.c.

The test program measures time between writing data to (/dev/ttyS0 1200 baud) 
and the moment the TIOCSERGETLSR call returns TIOCSER_TEMT.

With 3.5.0 this is as expected about 248 mS, with the newer kernel 3.10.12
it is about 19.5 mS which is plain wrong.

For a long time I had set the port parameters with setserial to uart 8250 and 
that worked until now (3.5.0 still does work)
I found that changing the portsettings with setserial "uart 16550A" the port
works as expected. 

Is it no longer possible to change those settings with
setserial??

I am willing and able to do more tests if needed.

best regards

Kees

PS  CC me please, as I am not on the list,

--nextPart1801756.uQFXhvlc4z
Content-Disposition: attachment; filename="TESTS_3.5.0"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="TESTS_3.5.0"

kees@SEPC002:~/projekten/hart_master$ ./a.out
mark 1 offset = 0.008000 ms
mark 2 offset = 247.808000 ms
kees@SEPC002:~/projekten/hart_master$ ./a.out
mark 1 offset = 0.008000 ms
mark 2 offset = 248.330000 ms
kees@SEPC002:~/projekten/hart_master$ ./a.out
mark 1 offset = 0.008000 ms
mark 2 offset = 247.706000 ms
 
--nextPart1801756.uQFXhvlc4z
Content-Disposition: attachment; filename="TESTS_3.10.12"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="TESTS_3.10.12"

kees@SEPC002:~/projekten/hart_master$ ./a.out
mark 1 offset = 0.008000 ms
mark 2 offset = 19.641000 ms
kees@SEPC002:~/projekten/hart_master$ ./a.out
mark 1 offset = 0.008000 ms
mark 2 offset = 19.588000 ms
kees@SEPC002:~/projekten/hart_master$ ./a.out
mark 1 offset = 0.007000 ms
mark 2 offset = 19.532000 ms
--nextPart1801756.uQFXhvlc4z
Content-Disposition: attachment; filename="t.c"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-csrc; charset="utf-8"; name="t.c"

/* this test program demonstrates the problem with Linux-3.10.12
* (I tested 3.10.2 also, had the problem too) 
* It shows the time between writing and signalling TX empty
* for standard serial port (/dev/ttyS0)  (8250)
*
*
* With older kernels (at least 3.5.0) it works as expected
*
* writing 26 chars at 1200 baud to the PORT  should take some 216 mS
* with the newer kernels it takes only 19mS
*
*/
 
#include <i386-linux-gnu/sys/time.h>
#include <stdio.h>
#include <termio.h>
#include        <fcntl.h>
#include		<stdlib.h>


struct termios tio;
char	teststring[]="abcdefghijklmnopqrstuvwxyz"; 

int main (int argc, char **argv)
{
	int fdn = -1;
	int parm = 0;
	struct timeval t1, t2;
	double spendtime;


	if((fdn = open ("/dev/ttyS0", O_RDWR)) < 0){
		fprintf(stderr,"Can open port \n");
		exit(-1);
	}

    tcgetattr(fdn, &tio);
    tio.c_cflag = CS8 | PARODD | B1200 | PARENB | CREAD | CLOCAL;                    // parity, baudrate
    tio.c_iflag = IGNBRK | INPCK;
    tio.c_lflag = 0;
    tio.c_oflag = 0;
    tio.c_cc[VMIN] = 1;                                                              // no input buffering
    tio.c_cc[VTIME] = 0;
    tcsetattr(fdn, TCSANOW, &tio);

// set start time
	gettimeofday((struct timeval*)&t1, NULL);
// write some data (216mS)
	write(fdn, &teststring, sizeof(teststring));
// get first interval, internal kernel handling
	gettimeofday((struct timeval*)&t2, NULL);
	spendtime = (t2.tv_sec - t1.tv_sec) * 1000.0;
	spendtime += (t2.tv_usec - t1.tv_usec) / 1000.0;
	printf("mark 1 offset = %lf ms	\n", spendtime);
// check TX_EMT
	while(!parm)
		ioctl(fdn, TIOCSERGETLSR, &parm);
// get second interval, all data should be written	
	gettimeofday((struct timeval*)&t2, NULL);
    spendtime = (t2.tv_sec - t1.tv_sec) * 1000.0;
    spendtime += (t2.tv_usec - t1.tv_usec) / 1000.0;
	printf("mark 2 offset = %lf ms	\n", spendtime);

	return(0);
}
--nextPart1801756.uQFXhvlc4z--
