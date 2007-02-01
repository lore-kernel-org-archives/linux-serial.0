From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: [BUG]: 2.6.19.2: Weird serial core issue
Date: Thu, 01 Feb 2007 09:19:19 -0600
Message-ID: <45C204F7.9060303@microgate.com>
References: <6d6a94c50701311833m5952c6fdn8e1f0db28d674e79@mail.gmail.com>	 <000201c745d9$4577fe20$2e01a8c0@acksys.local> <6d6a94c50702010238p7866f5a5m8824d2ca518eb704@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030588AbXBAPT2@vger.kernel.org>
In-Reply-To: <6d6a94c50702010238p7866f5a5m8824d2ca518eb704@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aubrey Li <aubreylee@gmail.com>
Cc: Tosoni <jp.tosoni@acksys.fr>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

Aubrey Li wrote:
> But When I type "ENTER" key,
> 
> I got
> ------------
> cflag = 0x1cb1, old = 0x80001cb1
> cflag = 0x1cb1, old = 0x1cb1
> ------------
> That means terminal setting is back to crtscts disabled. But here I
> didn't do anything to disable it, I just type "ENTER", crtscts setting
> should keep enabled. What makes it back to disabled? Now I guess there
> must be something wrong with serial core.

Is there an mgetty or similar program monitoring
the same serial port?

-- 
Paul Fulghum
Microgate Systems, Ltd.
