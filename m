From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] serial: remove "too much work for irq" printk
Date: Sat, 12 Jan 2008 13:58:02 -0800
Message-ID: <478937EA.1010208@zytor.com>
References: <20080112201543.GB12775@kvack.org>	<20080112212457.3bf534af@lxorguk.ukuu.org.uk>	<47893374.4080102@zytor.com> <20080112214230.241018d4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761377AbYALV61@vger.kernel.org>
In-Reply-To: <20080112214230.241018d4@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@kvack.org>, akpm@osdl.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Alan Cox wrote:
>> This is going to put trouble in other places unless, at least, it can be 
>> turned off.  The UART serial interface is heavily emulated as a console 
>> interface without an actual serial port behind it, both in hardware and 
>> software.  Rates will typically vastly exceed real serial port rates, 
> 
> Yes Dell do it, HP do it, IBM do it. Have done for years, never caused us
> a problem. Its only KVM tripping it.
> 
> As to bit rate we support up to about 1 to 1.5 Mbit.
> 

FWIW, the highest rate I've seen in hardware is a FIFO about 4K deep 
that can be polled at about 25 MHz when all the overhead is accounted for.

	-hpa
