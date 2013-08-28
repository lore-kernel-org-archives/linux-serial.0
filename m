From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Tue, 27 Aug 2013 23:05:36 -0700
Message-ID: <20130828060536.GA19160@kroah.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
 <52123A44.9090608@hurleysoftware.com>
 <CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
 <5212D602.2000005@hurleysoftware.com>
 <CAKohpomE+6fxwF4JsDUDCzf+LsWZ_deBsRzF_XYjQHZTPvp_jw@mail.gmail.com>
 <5213C5CA.7060206@hurleysoftware.com>
 <CAKohpo=rZn-0FwcK5gzyYXufpVvfFHXSz_bK0=EqJbTDNcxqMQ@mail.gmail.com>
 <CAKohpokL4_RZ7s=yyn8S5jKh5zpW_DaUK4ni5_x_qN2+0Bv-Uw@mail.gmail.com>
 <20130827231946.GA18233@kroah.com>
 <CAKohpomP6Cj0Jp6ZqKTqw6Tb3sc8UQo3D46JJ6+LB9ahUex1SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45388 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab3H1GDR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Aug 2013 02:03:17 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpomP6Cj0Jp6ZqKTqw6Tb3sc8UQo3D46JJ6+LB9ahUex1SQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>, Linaro Networking <linaro-networking@linaro.org>, Peter Hurley <peter@hurleysoftware.com>

On Wed, Aug 28, 2013 at 11:28:48AM +0530, Viresh Kumar wrote:
> On 28 August 2013 04:49, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > No need, I took them as-is, thanks for doing this work.
> 
> I believe this must go to few stable releases as well.. ??

Why, as it doesn't cause problems unless you are running rt kernels at
the moment, right?  Is there some other way to trigger the problem that
you know of?

Remember, stable is for "real" problems :)

thanks,

greg k-h
