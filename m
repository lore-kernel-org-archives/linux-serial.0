From: Maciej Szmigiero <mhej@o2.pl>
Subject: Re: [SERIAL]blacklist si3052 chip
Date: Tue, 26 Oct 2010 23:54:12 +0200
Message-ID: <4CC74E04.7080407@o2.pl>
References: <4CC73085.2070304@o2.pl> <20101026224940.22b4ac93@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101026224940.22b4ac93@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

W dniu 26.10.2010 23:49, Alan Cox pisze:
> On Tue, 26 Oct 2010 21:48:21 +0200
> Maciej Szmigiero <mhej@o2.pl> wrote:
> 
>> [SERIAL]blacklist si3052 chip
>>
>> Si3052-based softmodems aren't serial ports so don't bind serial driver to them.
>> Allows proper driver to bind to them.
> 
> Which is the proper driver ?
> 
> Alan
> 

Awaiting final review on the DAHDI reviewboard.

Maciej Szmigiero
