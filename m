From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Date: Mon, 11 Dec 2006 11:07:50 -0600
Message-ID: <457D9066.1030308@mvista.com>
References: <4533B8FB.5080108@mvista.com>	<20061210201438.tilman@imap.cc>	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>	<457CB32A.2060804@mvista.com> <20061211102016.43e76da2@localhost.localdomain> <457D8E35.9050706@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762956AbWLKRHy@vger.kernel.org>
In-Reply-To: <457D8E35.9050706@imap.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
List-Id: linux-serial@vger.kernel.org

Tilman Schmidt wrote:
> On Mon, 11 Dec 2006 10:20:16 +0000, Alan wrote:
>   
>> This looks wrong. You already have a kernel interface to serial drivers.
>> It is called a line discipline. We use it for ppp, we use it for slip, we
>> use it for a few other things such as attaching sync drivers to some
>> devices.
>>     
>
> I was under the impression that line disciplines need a user space
> process to open the serial device and push them onto it. Is there
> a way for a driver to attach to a serial port through the line
> discipline interface from kernel space, eg. from an initialization,
> module load, or probe function?
>   
Module initialization functions run in a task context, so that's
generally not a problem.  The probe function depends on the driver,
I guess, but most I have seen are in task context.

-Corey
