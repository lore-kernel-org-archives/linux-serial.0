From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] tty/vt: Return EBUSY if deallocating VT1 and it is busy
Date: Sun, 16 Jun 2013 19:35:08 +0200
Message-ID: <20925.63308.865094.602537@pilspetsen.it.uu.se>
References: <20130614213543.GA1896@kroah.com>
	<1371248665-1176-1-git-send-email-rosslagerwall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371248665-1176-1-git-send-email-rosslagerwall@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ross Lagerwall <rosslagerwall@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Ross Lagerwall writes:
 > Commit 421b40a6286e ("tty/vt: Fix vc_deallocate() lock order") changed
 > the behavior when deallocating VT 1.  Previously if trying to
 > deallocate VT1 and it is busy, we would return EBUSY.  The commit
 > changed this to return 0 (success).
 > 
 > This commit restores the old behavior.
 > 
 > Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>

This solves the VT blanking regression I've seen with the 3.10-rc
kernels.

Tested-by: Mikael Pettersson <mikpe@it.uu.se>

 > ---
 > On 06/14/2013 05:35 PM, Greg KH wrote:
 > > p.s. In the future, please cc: the people who handled the patch you are
 > > asking about, otherwise stuff like this often gets missed in the noise
 > > of lkml.
 > 
 > Yes, sorry about that.  I only remembered after I sent the email.
 > 
 >  drivers/tty/vt/vt_ioctl.c | 5 +----
 >  1 file changed, 1 insertion(+), 4 deletions(-)
 > 
 > diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
 > index fc2c06c..2bd78e2 100644
 > --- a/drivers/tty/vt/vt_ioctl.c
 > +++ b/drivers/tty/vt/vt_ioctl.c
 > @@ -289,13 +289,10 @@ static int vt_disallocate(unsigned int vc_num)
 >  	struct vc_data *vc = NULL;
 >  	int ret = 0;
 >  
 > -	if (!vc_num)
 > -		return 0;
 > -
 >  	console_lock();
 >  	if (VT_BUSY(vc_num))
 >  		ret = -EBUSY;
 > -	else
 > +	else if (vc_num)
 >  		vc = vc_deallocate(vc_num);
 >  	console_unlock();
 >  
 > -- 
 > 1.8.3.1
 > 
 > --
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
 > 
