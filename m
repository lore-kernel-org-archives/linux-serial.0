From: rich+ml@lclogic.com
Subject: Re: Non-standard baud rate setting 14400 ..Possible?
Date: Fri, 10 Oct 2003 14:41:54 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0310101434050.10597-100000@deadrat.localdomain>
References: <20031010195849.0f33ab62.gme@emig-software.de>
Reply-To: rich+ml@lclogic.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-64-164-130-3.dsl.snfc21.pacbell.net ([64.164.130.3]:34550
	"EHLO deadrat.localdomain") by vger.kernel.org with ESMTP
	id S262692AbTJJVl6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2003 17:41:58 -0400
In-Reply-To: <20031010195849.0f33ab62.gme@emig-software.de>
List-Id: linux-serial@vger.kernel.org
To: Gerald Emig <gme@emig-software.de>
Cc: Sampath Kumar <sampath@spartanlabs.com>, linux-serial@vger.kernel.org

Why not? Uart baud rate is 115200/divisor, use 4 for 28800, 5 for 14400.  
But you are right it is better to set uart to highest possible baud and
let modem convert, esp. if V.42bis compression is used.

On Fri, 10 Oct 2003, Gerald Emig wrote:

> Date: Fri, 10 Oct 2003 19:58:49 +0200
> From: Gerald Emig <gme@emig-software.de>
> To: Sampath Kumar <sampath@spartanlabs.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: Non-standard baud rate setting 14400 ..Possible?
> 
> 
> There is no such way;
> main reason is that the serial hardware does not support these data
> speeds (even under Win***).
> 
> But as I see from the rates that you mention, it seems that you talk via
> a modem. Note that modem speed and speed of the serial port are two
> different things. Modem speeds are normally handled by the modem
> (automatically or by AT-commands), not by the linux serial driver.
> 
> I hope this helps, but feel free to ask more questions.
> 
> 
> 
> On Fri, 10 Oct 2003 20:27:59 +0530
> "Sampath Kumar" <sampath@spartanlabs.com> wrote:
> 
> > Hello ,
> > 
> > Is there a way to set the serial port on the i386 Linux 2.4.17 at non
> > standard baud rates like 14400,28800,etc.?
> > 
> > Regards
> > Sampath
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-serial" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

