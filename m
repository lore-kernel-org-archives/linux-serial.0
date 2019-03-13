From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
Date: Wed, 13 Mar 2019 07:36:54 -0700
Message-ID: <20190313143654.GA7489@kroah.com>
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
 <20190312163356.GB13549@kroah.com>
 <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 13, 2019 at 07:59:53AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 12.03.19 17:33, Greg KH wrote:
> > On Tue, Mar 12, 2019 at 03:57:33PM +0100, Enrico Weigelt, metux IT consult wrote:
> >> ---
> >>  drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
> >>  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > No changelog or signed-off-by, sorry, please fix up the series and
> > resend.
> 
> Maybe the threading got messed up somehow (at least my tbird doesn't
> show it correctly), so you've probably didn't see my intro letter: there
> I wrote that this is yet WIP, not meant for actual submission, instead
> just to ask you folks whether my approach in general would be work.
> 

Threading worked just fine, but you still shouldn't send out patches
like this without any independant information in the patch itself saying
what it does and what it is for.  That's just bad engineering :)

Also, usually RFC like patches and series are ignored, I know I almost
always ignore them because if the author doesn't think they are ready to
be reviewed, why would I spend time on them compared to other patches
that their authors think are ready for review.

Remember, patch review is the most limited resource we have.

thanks,

greg k-h
