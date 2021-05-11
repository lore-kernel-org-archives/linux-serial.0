Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DFAC433ED
	for <linux-serial@archiver.kernel.org>; Tue, 11 May 2021 12:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F91961919
	for <linux-serial@archiver.kernel.org>; Tue, 11 May 2021 12:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhEKMWW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 May 2021 08:22:22 -0400
Received: from mail-out-00.hs-hannover.de ([192.108.52.125]:59276 "EHLO
        mail-out-00.hs-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231262AbhEKMWW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 May 2021 08:22:22 -0400
Received: from smtp.hs-hannover.de (mail-gateway-01.it.hs-hannover.de [192.108.52.122])
        by mail-out-00.hs-hannover.de (Postfix) with ESMTPS id 4FfcTl24xdz2ScDV
        for <linux-serial@vger.kernel.org>; Tue, 11 May 2021 14:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hs-hannover.de;
        s=2021; t=1620735675;
        bh=caTrZhVyn4lLAL2cqVpeqPoOVsqLVAKjTSqDzFSDjW0=;
        h=To:From:Subject:Date;
        b=rSy8qQsU4JleHORmjRZJdpWgVDA2Fv0x1rmhId2GcAmLViPa8vc9g0vQ9KPejlGwc
         BZMKPcrr9moGx+lK5MG8cKaA797c2tOH3m0IPfTtSLHIidUWReL4qCcb3TpdFfLrLT
         iCygDsNuFTfkzFWRpJP8vQ6fdoE7x3JlROVQLmT9zCn8kx9XMBTG0x0hiTQjBEeIzR
         pMuoziEmKYUEqsZWEJu2sDoTg1uZDgeAXEEGOh7JfczuG/AdjlMLVnTyjQZkEo4XaK
         fpCkAkKbWMcft6kCkoiqPB6+WKGlmuMDi3yg/QWmaoOlZOjT7dW2KIDtNPKICQRJ68
         4FLjBiTyWVq9Q==
Received: from mail.hs-hannover.de (HSH-EX-ARCHIV2.fh-h.de [141.71.3.219])
        by smtp.hs-hannover.de (Postfix) with ESMTP id 4FfcTl0hhzz1DSCG
        for <linux-serial@vger.kernel.org>; Tue, 11 May 2021 14:21:15 +0200 (CEST)
Received: from [192.168.9.149] (192.108.52.158) by HSH-EX3.fh-h.de
 (141.71.3.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 11 May
 2021 14:21:14 +0200
To:     linux-serial <linux-serial@vger.kernel.org>
From:   Marcin Mleczko <marcin.mleczko@hs-hannover.de>
Subject: Problem with Prolific PL2303 Driver and soft flow control
Organization: Hochschule Hannover
Message-ID: <bde0d3f5-b09d-9aaa-c068-bb7f4227aaa8@hs-hannover.de>
Date:   Tue, 11 May 2021 14:21:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------66C82C7BA715A493C8C5D754"
Content-Language: en-US
X-Originating-IP: [192.108.52.158]
X-ClientProxiedBy: HSH-EX5.fh-h.de (141.71.3.215) To HSH-EX3.fh-h.de
 (141.71.3.213)
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2021.5.11.121515, AntiVirus-Engine: 5.82.0, AntiVirus-Data: 2021.5.11.5820000
X-Seen-By: puremessage-edge-02.it.hs-hannover.de
X-PerlMx-Spam: Gauge=IIIIIIIII, Probability=9%, Report='
 RCVD_FROM_IP_DATE 0.1, HTML_00_01 0.05, HTML_00_10 0.05, MIME_TEXT_ONLY_MP_MIXED 0.05, BITCOIN_SEXTORTION 0, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_10000_PLUS 0, NO_CTA_URI_FOUND 0, NO_URI_HTTPS 0, SENDER_NO_AUTH 0, WEBMAIL_SOURCE 0, WEBMAIL_XOIP 0, WEBMAIL_X_IP_HDR 0, __ANY_URI 0, __ATTACHMENT_NOT_IMG 0, __ATTACHMENT_PHRASE 0, __BAT_BOUNDARY 0, __BITCOIN_ADDRESS_OBFU 0, __BODY_NO_MAILTO 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __CTYPE_MULTIPART_MIXED 0, __FRAUD_MONEY 0, __FRAUD_MONEY_BIG_COIN 0, __FRAUD_MONEY_BIG_COIN_DIG 0, __FRAUD_MONEY_CURRENCY 0, __FRAUD_MONEY_CURRENCY_DOLLAR 0, __FRAUD_MONEY_VALUE 0, __HAS_ATTACHMENT 0, __HAS_ATTACHMENT1 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_XOIP 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_TEXT_P2 0, __MIME_VERSION 0, __MOZILLA_USER_AGENT 0, __NO_HTML_TAG_RAW 0, __PHISH_SPEAR_SUBJ_ALERT 0, __RCVD_FROM_DOMAIN 0,
 __RUS_OBFU_PHONE 0, __SANE_MSGID 0, __SEXTORTION_PORN 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NAME 0, __URI_MAILTO 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0'
X-HSH-Scanned: YES
X-HSH-Spam-Probability: 9%
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--------------66C82C7BA715A493C8C5D754
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Dear experts,

I've got several of these Prolific PL2303 USB to Serial adapters (lsusb 
output below) and have found that they do not send any data when the 
IXON bit is set.

What I've done so far:

A Null-Modem Cable (pins 2--3, 3--2, 5--5 connected) connects an 
on-board serial (RS232) port (/dev/ttyS0) to a PL2303-based USB to 
serial adapter (/dev/ttyUSB0).

When running sender.c on ttyS0 for transmitting and IXON is set, and 
receiver.c on ttyUSB0 for receiving  everything works fine: some data is 
being received, then a short break and then the rest of the data 
arrives.(sender.c and receiver.c are attached)

When I reverse the direction: sender.c on ttyUSB0 for transmitting and 
IXON is set, and receiver.c on ttyS0 used for receiving, no data 
arrives. Checking with an oscilloscope on the rx/tx lines reveals that 
the problem lies within the transmitting USB to serial adapter as no 
data (pulses) are present on the lines. Sending VSTART or VSTOP from the 
receiver site has no effect.

For comparison: clearing the IXON bit (in sender.c on ttyUSB0) makes the 
data flow albeit disabling soft flow control. So a hardware or user 
space (libc) problem can be ruled out, right?

I hope this is of any help and I'd be willing to carry out further 
testing if needed.

Marcin

[marcin@carbon18 ~]$ lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 002: ID 0bda:0328 Realtek Semiconductor Corp. USB3.0-CRW
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 005: ID 06cb:009a Synaptics, Inc. Metallica MIS Touch 
Fingerprint Reader
Bus 001 Device 004: ID 5986:2115 Acer, Inc Integrated Camera
Bus 001 Device 006: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial 
Port / Mobile Action MA-8910P
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

[marcin@carbon18 ~]$ uname -a
Linux carbon18 5.11.18-1-MANJARO #1 SMP PREEMPT Sun May 2 11:48:22 UTC 
2021 x86_64 GNU/Linux

-- 
*Marcin Mleczko*
Hochschule Hannover
Fakultät I, Elektro- und Informationstechnik
Ricklinger Stadtweg 120
30459 Hannover
Tel.: +49 511 9296 1298
marcin.mleczko@hs-hannover.de

--------------66C82C7BA715A493C8C5D754
Content-Type: text/x-csrc; charset="UTF-8"; name="receiver.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="receiver.c"

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <termios.h>

#define DEV_FILE1 "/dev/ttyUSB0"
//#define DEV_FILE1 "/dev/ttyS0"

int set_interface_attribs(int, int);
int vStart, vStop;
int main (){
	char txt[20] = "lkdkf\n";
	char rBuf[300];
	int fid, bw, br, i,k;
	


	fid = open(DEV_FILE1, O_RDWR);
	if (fid < 0) {
		printf("fid: %d\n", fid);
		perror("open: ");
		printf("%s\n", strerror(errno));
		return -1;
	}
	set_interface_attribs(fid, B9600);

	for (i=0; i<8; i++){		// 1st loop - start receiving some data
		for (k=0; k<4; k++){

			br = read(fid, rBuf, sizeof(rBuf));
			printf("%d %s, ", *rBuf, rBuf); fflush(stdout);
			memset(rBuf, 0, 300);
		}
		printf("--1\n"); fflush(stdout);
	}

	txt[0] = vStop;
	bw = write(fid, txt, 1);	// simulate receive buffer full


	for (i=0; i<2; i++){		// 2nd loop - continue trying to receive data (with VTIME timeout) to check that no data are being sent
		for (k=0; k<4; k++){
			br = read(fid, rBuf, sizeof(rBuf));
			printf("%d %s, ", *rBuf, rBuf); fflush(stdout);
			memset(rBuf, 0, 300);
		}
		printf("--2\n"); fflush(stdout);
	}

	txt[0] = vStart;
	bw = write(fid, txt, 1);	// signal "receiver ready again" to sender

	for (i=0; i<50; i++){		// 3rd loop - receiving data goes on
		for (k=0; k<4; k++){
			br = read(fid, rBuf, sizeof(rBuf));
			printf("%d %s, ", *rBuf, rBuf); fflush(stdout);
			memset(rBuf, 0, 300);
		}
		printf("--3\n"); fflush(stdout);
	}


	close(fid);
	return 0;
	}


int set_interface_attribs(int fd, int speed)
{
    struct termios tty;

    if (tcgetattr(fd, &tty) < 0) {
        printf("Error from tcgetattr: %s\n", strerror(errno));
        return -1;
    }

    cfsetospeed(&tty, (speed_t)speed);
    cfsetispeed(&tty, (speed_t)speed);
/*c_iflag*/

	tty.c_iflag &= ~INPCK;						/* don't Enable input parity checking. */
	tty.c_iflag &= ~ISTRIP;						/* don't Strip off eighth bit. */
	tty.c_iflag &= ~INLCR;						/* don't Translate NL to CR on input. */
	tty.c_iflag &= ~ICRNL;						/* don't Translate carriage return to newline on input. */
	//~ tty.c_iflag |= ICRNL;						/* Translate carriage return to newline on input. */
	tty.c_iflag &= ~IUCLC;						/* don't Map uppercase characters to lowercase on input. */
	tty.c_iflag &= ~IXON;						/* don't Enable XON/XOFF flow control on output. */
	//~ tty.c_iflag |= IXON;						/* Enable XON/XOFF flow control on output. */
	tty.c_iflag &= ~IXOFF;						/* don't Enable XON/XOFF flow control on input. */
	//~ tty.c_iflag |= IXOFF;						/* Enable XON/XOFF flow control on input. */
	tty.c_iflag &= ~IXANY;						/* don't Enable XON/XOFF flow control on input. */
	//~ tty.c_iflag |= IXANY;						/* Enable XON/XOFF flow control on input. */

/*c_oflag*/    
	tty.c_oflag &= ~INPCK;						/* don't Enable implementation-defined output processing. */

/*c_cflag*/
              

	// clear what needs to be cleard
	tty.c_cflag &= ~CSTOPB;						/* only need 1 stop bit */
	tty.c_cflag &= ~PARENB;						/* no parity bit */
	tty.c_cflag &= ~CRTSCTS;					/* no hardware flowcontrol */
	tty.c_cflag &= ~(CS5 | CS6 | CS7 | CS8);	/* clear all CSIZE bits */
	
	// set what needs to be set
	tty.c_cflag |= CS8;							/* Character size mask.  Values are CS5, CS6, CS7, or CS8.*/
	tty.c_cflag |= CLOCAL;						/* ignore modem control lines */
	tty.c_cflag |= CREAD;						/* enable receiver */
	

/*c_lflag*/
	tty.c_lflag &= ~ISIG;			/* don't generate the corresponding signal on INTR, QUIT, SUSP, or DSUSP */
	//~ tty.c_lflag |=  ICANON;			/* Enable canonical mode */
	tty.c_lflag &= ~ICANON;			/* don't Enable canonical mode */
	tty.c_lflag &= ~IEXTEN;			/* don't Enable implementation-defined input processing */
	tty.c_lflag &=  ~ECHO;			/* don't Echo input characters */
	//~ tty.c_lflag |=  ECHO;			/* don't Echo input characters */

    /* only for non canonical mode; fetch bytes as they become available */
    tty.c_cc[VMIN] = 0;
    tty.c_cc[VTIME] = 20;
    vStart = tty.c_cc[VSTART];
    vStop = tty.c_cc[VSTOP];
	printf("VSTART: %d, VSTOP: %d\n", tty.c_cc[VSTART], tty.c_cc[VSTOP]); fflush(stdout);

    if (tcsetattr(fd, TCSANOW, &tty) != 0) {
        printf("Error from tcsetattr: %s\n", strerror(errno));
        return -1;
    }
    return 0;
}

--------------66C82C7BA715A493C8C5D754
Content-Type: text/x-csrc; charset="UTF-8"; name="sender.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sender.c"

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <termios.h>

#define DEV_FILE0 "/dev/ttyS0"
//#define DEV_FILE0 "/dev/ttyUSB0"

int set_interface_attribs(int, int);

int main (){
	char txt[300] = "lg  ";
	char rBuf[300];
	int fid, bw, br;
	

	fid = open(DEV_FILE0, O_RDWR | O_NDELAY | O_NOCTTY);
	if (fid < 0) {
		printf("fid: %d\n", fid);
		perror("open: ");
		printf("%s\n", strerror(errno));
		return -1;
	}
	if ( ! isatty(fid) ) {
        printf("Not a TTY device.n");
        return -1;
     }
	set_interface_attribs(fid, B9600);

	while (1){
	bw = write(fid, txt, strlen(txt)); 
	if (bw < 0) {
		printf("bw: %d\n", bw);
		perror("write: ");
		printf("%s", strerror(errno));
		return -1;
	}

	printf("%d bytes: %s\n", bw, txt); fflush(stdout);
	txt[3]++;
	sleep(1);
	}

	close(fid);
	return 0;
	}


int set_interface_attribs(int fd, int speed)
{
    struct termios tty;

    if (tcgetattr(fd, &tty) < 0) {
        printf("Error from tcgetattr: %s\n", strerror(errno));
        return -1;
    }

    cfsetospeed(&tty, (speed_t)speed);
    cfsetispeed(&tty, (speed_t)speed);
/*c_iflag*/

	tty.c_iflag &= ~INPCK;						/* don't Enable input parity checking. */
	tty.c_iflag &= ~ISTRIP;						/* don't Strip off eighth bit. */
	tty.c_iflag &= ~INLCR;						/* don't Translate NL to CR on input. */
	tty.c_iflag |=  IGNCR;						/* Ignore carriage return on input. */	
	tty.c_iflag &= ~ICRNL;						/* don't Translate carriage return to newline on input. */
	tty.c_iflag &= ~IUCLC;						/* don't Map uppercase characters to lowercase on input. */
	//tty.c_iflag &= ~IXON;						/* don't Enable XON/XOFF flow control on output. */
	tty.c_iflag |= IXON;						/* Enable XON/XOFF flow control on output. */
	//tty.c_iflag &= ~IXOFF;						/* don't Enable XON/XOFF flow control on input. */
	tty.c_iflag |= IXOFF;						/* Enable XON/XOFF flow control on input. */
	tty.c_iflag &= ~IXANY;						/* don't (XSI) Typing any character will restart stopped output. */
	//~ tty.c_iflag |= IXANY;						/* (XSI) Typing any character will restart stopped output. */


/*c_oflag*/    
	tty.c_oflag &= ~INPCK;						/* don't Enable implementation-defined output processing. */


/*c_cflag*/
	// clear what needs to be cleard
	tty.c_cflag &= ~CSTOPB;						/* only need 1 stop bit */
	tty.c_cflag &= ~PARENB;						/* no parity bit */
	tty.c_cflag &= ~CRTSCTS;					/* no hardware flowcontrol */
	tty.c_cflag &= ~(CS5 | CS6 | CS7 | CS8);	/* clear all CSIZE bits */
	
	// set what needs to be set
	tty.c_cflag |= CS8;							/* Character size mask.  Values are CS5, CS6, CS7, or CS8.*/
	tty.c_cflag |= CLOCAL;					/* ignore modem control lines */
	tty.c_cflag |= CREAD;						/* enable receiver */
	

/*c_lflag	*/
	tty.c_lflag &= ~ISIG;			/* don't generate the corresponding signal on INTR, QUIT, SUSP, or DSUSP */
	tty.c_lflag |=  ICANON;			/* Enable canonical mode */
	//~ tty.c_lflag &=  ~ICANON;			/* Enable canonical mode */
	tty.c_lflag &= ~IEXTEN;			/* don't Enable implementation-defined input processing */
	tty.c_lflag &=  ~ECHO;			/* don't Echo input characters */


    if (tcsetattr(fd, TCSANOW, &tty) != 0) {
        printf("Error from tcsetattr: %s\n", strerror(errno));
        return -1;
    }
    return 0;
}

--------------66C82C7BA715A493C8C5D754--
