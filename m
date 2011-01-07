From: Michal Simek <monstr@monstr.eu>
Subject: Re: Uartlite - ulite_transmit
Date: Fri, 07 Jan 2011 08:48:08 +0100
Message-ID: <4D26C538.3010101@monstr.eu>
References: <4D2465E0.2000707@monstr.eu> <4D246672.3070002@monstr.eu>	<87vd22h3dq.fsf@macbook.be.48ers.dk> <4D257D61.2060400@monstr.eu>	<87r5cqh0bn.fsf@macbook.be.48ers.dk> <4D25871D.2000408@monstr.eu> <87mxnegy4u.fsf@macbook.be.48ers.dk>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56307 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab1AGHsN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Jan 2011 02:48:13 -0500
Received: by fxm20 with SMTP id 20so16726272fxm.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Jan 2011 23:48:11 -0800 (PST)
In-Reply-To: <87mxnegy4u.fsf@macbook.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org

Peter Korsgaard wrote:
>>>>>> "Michal" == Michal Simek <monstr@monstr.eu> writes:
> 
> Hi,
> 
>  >> But I still don't understand why you would want to burn CPU spinning
>  >> when you know the UART will be busy for a while. Leaving it alone
>  >> until it generates the TX fifo empty interrupt seems more logical to
>  >> me.
> 
>  Michal> I didn't know when tx fifo was full and then empty interrupt is
>  Michal> generated. I have added some debug things to driver and I am going to
>  Michal> look into.
> 
>  Michal> I just changed return value and I have got correct output and
>  Michal> then I sent this email to check if is correct or not.
> 
> According to the spec, you should get an interrupt when RX !empty or TX
> empty.
> 
> We wouldn't ever be able to send more bytes than fits in the TX fifo if
> it didn't.

Yes, I know.

I looked at that loop and I think that we should reread actual status 
before ulite_transmit because status reg can be changed when 
ulite_receive is executed. What do you think? (BTW: status reading can 
be moved directly to ulite_receive/transmit functions)

     do {
         int stat = ioread32be(port->membase + ULITE_STATUS);
         busy  = ulite_receive(port, stat);
         stat = ioread32be(port->membase + ULITE_STATUS); // check 
status again
         busy |= ulite_transmit(port, stat);
         n++;
     } while (busy);



I did some investigating and I found:
1. xmit circ buffer contains what needs to be printed but it is not printed.

Here is circ_buf structure, pointer to buffer and head/tail

struct circ_buf {
	char *buf;
	int head;
	int tail;
};


Part of the broken log. ( There should be in Welcome to and log)

adding dns 172.16.0.5
 >
 >  >> Yeah, that loop should probably be time based (and perhaps calculated
 >  >> from baud rate).
 >
 >  Michal> It is hard to say if you can find out any accurate number of 
loops
 >  Michal> which is baud rate dependent.
 >
 > Not loops, microseconds (or rather jiffies).
 >
adding dns 172.16.10.1
Starting portmap:
Starting uWeb server:

Welc
mdm login:

Here is the circ buffer:
(NOTE: mdm login is coming from getty and it is at the beginning)

5ed72000: 0d0d0a6d 646d206c 6f67696e 3a20200d    ...mdm login:  .
5ed72010: 0a4d6f75 6e74696e 67207661 723a200d    .Mounting var: .
5ed72020: 0a506f70 756c6174 696e6720 2f766172    .Populating /var
5ed72030: 3a200d0a 52756e6e 696e6720 6c6f6361    : ..Running loca
5ed72040: 6c207374 61727420 73637269 7074732e    l start scripts.
...
5ed721b0: 646e7320 3137322e 31362e30 2e350d0a    dns 172.16.0.5..
5ed721c0: 61646469 6e672064 6e732031 37322e31    adding dns 172.1
5ed721d0: 362e3130 2e310d0a 53746172 74696e67    6.10.1..Starting
5ed721e0: 20706f72 746d6170 3a0d0a53 74617274     portmap:..Start
5ed721f0: 696e6720 75576562 20736572 7665723a    ing uWeb server:
5ed72200: 0d0a0d0a 57656c63 6f6d6520 746f0d0a    ....Welcome to..
5ed72210: 205f5f5f 5f5f2020 20202020 205f2020     _____       _
5ed72220: 20202020 20202020 205f2020 20202020             _
5ed72230: 5f0d0a7c 205f5f5f 205c2020 2020207c    _..| ___ \     |
5ed72240: 207c2020 20202020 2020207c 207c2020     |         | |
5ed72250: 2020285f 290d0a7c 207c5f2f 202f205f      (_)..| |_/ / _
5ed72260: 5f5f207c 207c5f20 20205f5f 205f207c    __ | |_   __ _ |
5ed72270: 207c2020 2020205f 20205f20 5f5f2020     |     _  _ __
5ed72280: 205f2020 205f205f 5f20205f 5f0d0a7c     _   _ __  __..|
5ed72290: 20205f5f 2f202f20 5f205c7c 205f5f7c      __/ / _ \| __|
5ed722a0: 202f205f 60207c7c 207c2020 20207c20     / _` || |    |
5ed722b0: 7c7c2027 5f205c20 7c207c20 7c207c5c    || '_ \ | | | |\
5ed722c0: 205c2f20 2f0d0a7c 207c2020 207c2020     \/ /..| |   |
5ed722d0: 5f5f2f7c 207c5f20 7c20285f 7c207c7c    __/| |_ | (_| ||
5ed722e0: 207c5f5f 5f5f7c20 7c7c207c 207c207c     |____| || | | |
5ed722f0: 7c207c5f 7c207c20 3e20203c 0d0a5c5f    | |_| | >  <..\_
5ed72300: 7c202020 205c5f5f 5f7c205c 5f5f7c20    |    \___| \__|
5ed72310: 5c5f5f2c 5f7c5c5f 5f5f5f5f 2f7c5f7c    \__,_|\_____/|_|
5ed72320: 7c5f7c20 7c5f7c20 5c5f5f2c 5f7c2f5f    |_| |_| \__,_|/_
5ed72330: 2f5c5f5c 0d0a0d0a 6f6e206d 646d0d0a    /\_\....on mdm..
5ed72340: 0d0a0000 00000000 00000000 00000000    ................

I look at head and tail values and they are OK "c" (in Welc) is called.
Exact values are: head:0x342, tail:208.(You can check that it is correct 
range in circ buffer)

Let me describe what driver did:

1. Before fault happen:
ISR is called, status is 0x18 (interrupt enabled, tx fifo full) just to 
ulite_transmit and detect TXFULL and return to ISR. Head and tail are 
correct
2. Broken part
ISR is called, status is 0x14 (interrupt enabled, tx fifo empty), jump 
to ulite_transmit. Here I am printing (head and tail values are zero). 
Xmit buffer address is the same. Then uart_circ_empty(xmit) detects that 
head and tail are the same which means nothing to print.

My question: Is there any part of the code which can change xmit head 
and tail values?

I will try to setup watchpoints on that addresses to see which part of 
the code is breaking that addresses.

BTW: Getty is providing that login prompt. Could it be an issue with getty?


Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian

