From: Gerald Emig <gme@emig-software.de>
Subject: Re: Remote serial port configuration.
Date: Fri, 5 Mar 2004 14:23:05 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040305142305.1687d547.gme@emig-software.de>
References: <Pine.LNX.4.44.0403042021001.5144-100000@pcz-vijayck.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.185]:9443 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262567AbUCEMYf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Mar 2004 07:24:35 -0500
In-Reply-To: <Pine.LNX.4.44.0403042021001.5144-100000@pcz-vijayck.sasken.com>
List-Id: linux-serial@vger.kernel.org
To: Vijaymahantesh Kalakoti <vijayck@sasken.com>
Cc: linux-serial@vger.kernel.org

On Thu, 4 Mar 2004 20:33:58 +0530 (IST)
Vijaymahantesh Kalakoti <vijayck@sasken.com> wrote:

> 
> Hi all,
> 
> I have connected two pc's through serial port. And one of the pc is 
> configured to run a terminal on the serial port( ttyS0 ) by
> configuring the getty to run on serial port. 
> 
> I have written a program to send the username & password from the
> other computer. The configuration of serial port on both the systems
> are same.
> 
> But I am not able to login to the system. But when I give a delay
> 1/100 th of a second or more between sending of username & password,
> then it is getting logging into the system.
> 
> Can I log in without introducing any delays?

May be the following helps:

Current getty programs do clear their input buffer before they issue the
"Password:" prompt.


> 
> Pls help me in this regard.
> 
> Thanks & regards
> vijay kalkoti
> -- 
> 
> 



Gerald Emig

--
EMIG Software, Engelstr. 17, D-66564 Ottweiler, Germany
Tel.+49(0)6858-699567, Fax.699568, gme@emig-software.de
