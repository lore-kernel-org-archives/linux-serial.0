From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: Re: [PATCH] drivers/tty/serial/mcf.c: fix typo on MCF_CONSOLE
Date: Sun, 12 Apr 2015 18:00:54 +0200
Message-ID: <20150412160054.GA3152@station>
References: <1428851401-5008-1-git-send-email-valentinrothberg@gmail.com>
 <552A949B.5010006@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <552A949B.5010006@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Sun, Apr 12, 2015 at 11:51:55AM -0400, Peter Hurley wrote:
> Hi Valentin,
> 
> On 04/12/2015 11:10 AM, Valentin Rothberg wrote:
> > Correct reference in C-comment after #endif.
> > 
> > Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> > ---
> > I found this issue with ./scripts/checkkconfigsymbols.py
> > ---
> >  drivers/tty/serial/mcf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
> > index a9b0ab38a68c..a61031eca1b7 100644
> > --- a/drivers/tty/serial/mcf.c
> > +++ b/drivers/tty/serial/mcf.c
> > @@ -597,7 +597,7 @@ console_initcall(mcf_console_init);
> >  #define	MCF_CONSOLE	NULL
> >  
> >  /****************************************************************************/
> > -#endif /* CONFIG_MCF_CONSOLE */
> > +#endif /* MCF_CONSOLE */
> 
> Please check your results; the correct change would be
> 
> #endif /* CONFIG_SERIAL_MCF_CONSOLE */

Thank you for catching that.  That's what I intended to; sorry for
this mistake.  I'll send a second corrected version of this patch.

Kind regards,
 Valentin

> Regards,
> Peter Hurley
> 
> >  /****************************************************************************/
> >  
> >  /*
> > 
> 
