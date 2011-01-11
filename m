From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2 v1] davinci: support disabling modem status
	interrupts on	SOC UARTS
Date: Tue, 11 Jan 2011 21:13:03 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024834972E@dbde02.ent.ti.com>
References: <1294230392-29564-1-git-send-email-michael.williamson@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024829BCD4@dbde02.ent.ti.com>
	<4D2C5031.30507@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4D2C5031.30507-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Cc: "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "gregkh-l3A5Bk7waGM@public.gmane.org" <gregkh-l3A5Bk7waGM@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 11, 2011 at 18:12:25, Michael Williamson wrote:
> [...]
> This was pretty much what the original patch I had proposed did.  There are
> actually two termios flags that cause MS interrupts to be enabled by the
> driver, CLOCAL (disabled) or CRTSCTS (enabled).  I observed that some
> process after the kernel had completed booting (getty, I think)
> was calling set_termios with CLOCAL disabled (not CRTSCTS enabled).  I could
> probably alter the getty args to work around it, but it's a bit of a hole to
> not have something in the kernel to preclude sending the OS to "interrupt 
> hell".
> 
> Is there another way to accomplish what you are suggesting that is different
> from the original patch?
> 
> Thanks for the comments.
> 
> -Mike
> 
> Background: The original patch (not accepted) is here
> https://patchwork.kernel.org/patch/442671/
> 
> This kicked a second email thread:
> http://marc.info/?l=linux-serial&m=129409970003827&w=4
> 
> From that thread, it was suggested to add a port flag to the driver
> flags structure for disabling MS interrupts.
> 
> Driver Tweak patch (not accepted):
> https://patchwork.kernel.org/patch/450771/
> 
> From that thread, it was suggested to override the I/O methods and hide
> the problem back in the platform code (this patch).
> 
> All three proposed patches work for me.  I'd gladly submit a fourth if
> suggested -- this problem pretty much kills a couple of platform
> configurations we are working on...
> 
> > Thanks,
> > Prakash
> > 
Thanks for clarifying. Looks like this is what we can do as of now.

Thanks,
Prakash
