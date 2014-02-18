From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] vt: drop an useless enum and assignment.
Date: Tue, 18 Feb 2014 10:45:05 -0800
Message-ID: <20140218184505.GB29209@kroah.com>
References: <1391731567-10260-1-git-send-email-kilobyte@angband.pl>
 <20140213184101.GB18522@kroah.com>
 <20140216014329.GA30022@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47658 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbaBRSnk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 13:43:40 -0500
Content-Disposition: inline
In-Reply-To: <20140216014329.GA30022@angband.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Sun, Feb 16, 2014 at 02:43:29AM +0100, Adam Borowski wrote:
> On Thu, Feb 13, 2014 at 10:41:01AM -0800, Greg Kroah-Hartman wrote:
> > On Fri, Feb 07, 2014 at 01:06:07AM +0100, Adam Borowski wrote:
> > > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > > ---
> > >  drivers/tty/vt/vt.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > > index 0377c52..3baed72 100644
> > > --- a/drivers/tty/vt/vt.c
> > > +++ b/drivers/tty/vt/vt.c
> > > @@ -1588,7 +1588,7 @@ static void restore_cur(struct vc_data *vc)
> > >  	vc->vc_need_wrap = 0;
> > >  }
> > >  
> > > -enum { ESnormal, ESesc, ESsquare, ESgetpars, ESgotpars, ESfunckey,
> > > +enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
> > >  	EShash, ESsetG0, ESsetG1, ESpercent, ESignore, ESnonstd,
> > >  	ESpalette, ESosc };
> > >  
> > > @@ -1811,9 +1811,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
> > >  			vc->vc_par[vc->vc_npar] *= 10;
> > >  			vc->vc_par[vc->vc_npar] += c - '0';
> > >  			return;
> > > -		} else
> > > -			vc->vc_state = ESgotpars;
> > > -	case ESgotpars:
> > > +		}
> > >             vc->vc_state = ESnormal;
> > >             switch(c) {
> > >             case 'h':
> > 
> > Yes, this looks odd, but are you sure it's not going to break anything?
> 
> This is a proper enum (ie, no arithmetic is done on it), and the only place
> the value of ESgotpars could get assigned is one I removed, which then got
> overwritten on the very next statement.
> 
> > And always cc: public mailing lists, kernel development is not done in
> > private.
> 
> Okay.  Posting to -kernel would be spamming just for several bytes of
> optimization, and I've read somewhere that -serial is inappropriate for vt
> related patches; thanks for clearing this up.

Ok, care to resend along with your other vt patch?

thanks,

greg k-h
