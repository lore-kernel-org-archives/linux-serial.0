From: "Rick Bolen(gm)" <rickbolgm@gmail.com>
Subject: using a RS232->RS485 adapter issues...
Date: Mon, 22 Apr 2013 14:19:04 -0400
Message-ID: <51757F18.8070908@gmail.com>
Reply-To: rickbolgm@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:41157 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab3DVSTK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Apr 2013 14:19:10 -0400
Received: by mail-qc0-f180.google.com with SMTP id b40so3403209qcq.11
        for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2013 11:19:09 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I'm perplexed in using a RS232C->RS485 dongle that worked perfectly on a 
Debian Lenny box for years. Now that I'm migrating to Debian Wheezy, 
albeit, different mobo (Intel mini-itx D2500CC) and serial card 
(RocketPort), this dongle doesn't work as before.

The dongle sourced working power *from* the host serial port 
(cannibalizing DTR, etc?). Using the RocketPort, I have to power the 
dongle separately and create a simple data only pass-thru (TX\RX\GND, no 
other connections) connection for this dongle to function.

So I don't know if there are voltage level differences on the DTR etc 
that result in the failure to power the dongle from the serial port.

Also, having examined the serial port configs with stty between the two 
machines, and making all the settings identical, I don't understand why 
I have to create the data only pass-thru for communication to work. All 
hw\sw flow controls are identical between the working machine and the 
new machine... at least as far as stty reports.

1) What serial pin can reliably measure to determine voltage level for 
the port (i.e. 12V, 5V, 3.3V)?

2) What else might be different between the working machine and the new 
machine with respect to serial port config?

3) Is there an stty config that should effectively provide me with the 
same "port config\functionality" that the data only pass-thru adapter 
gives me (i.e., can I achieve in software config what I'm doing in 
hardware)?

The working (and duplicated) stty config is:

speed 9600 baud; rows 0; columns 0; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; 
eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt 
= ^R;
werase = ^W; lnext = ^V; flush = ^O; min = 0; time = 0;
-parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl 
-ixon -ixoff -iuclc -ixany -imaxbel -iutf8
-opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 
vt0 ff0
-isig -icanon -iexten -echo echoe echok -echonl -noflsh -xcase -tostop 
-echoprt echoctl echoke

Or in stty form:

0:4:cbd:a30:3:1c:7f:15:4:0:0:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0


Thanks,

Rick


