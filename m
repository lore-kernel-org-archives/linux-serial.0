From: Andi Kleen <andi@firstfloor.org>
Subject: Re: 4.3 serial driver crashes with console shortly after boot
Date: Wed, 11 Nov 2015 17:50:36 +0100
Message-ID: <20151111165035.GL3533@two.firstfloor.org>
References: <20151110002939.GG3533@two.firstfloor.org>
 <56414DE9.20707@hurleysoftware.com>
 <20151110223957.GI3533@two.firstfloor.org>
 <20151110224340.GA30452@two.firstfloor.org>
 <56427AAC.3000409@hurleysoftware.com>
 <56432316.3040602@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56432316.3040602@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Andi Kleen <andi@firstfloor.org>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 11, 2015 at 06:14:30AM -0500, Peter Hurley wrote:
> On 11/10/2015 06:15 PM, Peter Hurley wrote:
> > On 11/10/2015 05:43 PM, Andi Kleen wrote:
> >> On Tue, Nov 10, 2015 at 11:39:57PM +0100, Andi Kleen wrote:
> >>>> I've just tried to reproduce this without success on my current
> >>>> tree which has some additional patches I just posted this am. They weren't
> >>>> intended to fix crashes but they directly impact the area of concern. Could
> >>>> you try these three?
> >>>>
> >>>> [PATCH v2 2/4] n_tty: Ignore all read data when closing
> >>>> [PATCH v2 3/4] tty: Abstract and encapsulate tty->closing behavior
> >>>> [PATCH v2 4/4] tty: Remove drivers' extra tty_ldisc_flush()
> >>>>
> >>> Applying the three patches fixes the crash. 
> >>> I haven't tried to figure out which one did the trick.
> >>
> >> Actually I was wrong sorry. It still crashes, but now it doesn't
> >> hang the system anymore.
> > 
> > Argghh.
> > Can you run the patch below and send me full dmesg (privately if you prefer)?
> 
> Nevermind. I see how it's happening now; it's being initiated by hangup,
> not close. FWIW, it's been like that nearly forever; your user-space/tool is
> triggering this because ECHO is on.

It's just agetty i believe, but there may be some funkiness going on
with the terminal server or the cable.

Thanks. I'll just add a NULL pointer check for now, until you have
a real patch.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
