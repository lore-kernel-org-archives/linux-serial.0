From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Sat, 04 Aug 2007 11:21:07 -0700
Message-ID: <46B4C393.4020506@howardsilvan.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>	 <46A84B4A.6070902@shaw.ca> <46A8C6F1.4080309@howardsilvan.com>	 <20070726173121.70088a92@the-village.bc.nu>	 <46A98845.8010806@howardsilvan.com> <46A9F712.70706@imap.cc>	 <46D33636.7070200@microgate.com> <46AA5A0E.1050600@howardsilvan.com>	 <1185578908.2989.15.camel@x2> <46AACB4D.7080004@howardsilvan.com> <2c0942db0707280941n1b9e1f7i9c0de332286e8aac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:33040 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbXHDSVM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 4 Aug 2007 14:21:12 -0400
In-Reply-To: <2c0942db0707280941n1b9e1f7i9c0de332286e8aac@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Paul Fulghum <paulkf@microgate.com>, Tilman Schmidt <tilman@imap.cc>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

Ray Lee wrote:

>On 7/27/07, Lee Howard <faxguy@howardsilvan.com> wrote:
>  
>
>>Curiously, the session at 38400 bps that skipped 858 bytes... coincided,
>>not just in sequence but also in precice timing within the session, with
>>a small but noticeable disk load that I caused by grepping through a
>>hundred session logs.  (I can't reproduce it easily, though, because of
>>disk caching.)
>>    
>>
>
>`echo 1 > /proc/sys/vm/drop_caches` will clear out most (all?) of what
>the kernel has cached from the drive. It's there just for this kind of
>repeatability of tests...
>

And in repeat tests it is quite evident that IDE disk activity is, 
indeed, at least part of the problem.  As IDE disk activity increases an 
increased amount of data coming in on the serial port goes missing.

Thanks,

Lee.
