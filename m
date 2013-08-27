From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Tue, 27 Aug 2013 16:19:46 -0700
Message-ID: <20130827231946.GA18233@kroah.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
 <52123A44.9090608@hurleysoftware.com>
 <CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
 <5212D602.2000005@hurleysoftware.com>
 <CAKohpomE+6fxwF4JsDUDCzf+LsWZ_deBsRzF_XYjQHZTPvp_jw@mail.gmail.com>
 <5213C5CA.7060206@hurleysoftware.com>
 <CAKohpo=rZn-0FwcK5gzyYXufpVvfFHXSz_bK0=EqJbTDNcxqMQ@mail.gmail.com>
 <CAKohpokL4_RZ7s=yyn8S5jKh5zpW_DaUK4ni5_x_qN2+0Bv-Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43020 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab3H0XR2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Aug 2013 19:17:28 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpokL4_RZ7s=yyn8S5jKh5zpW_DaUK4ni5_x_qN2+0Bv-Uw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>, Linaro Networking <linaro-networking@linaro.org>, Peter Hurley <peter@hurleysoftware.com>

On Fri, Aug 23, 2013 at 01:56:08PM +0530, Viresh Kumar wrote:
> On 21 August 2013 10:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 21 August 2013 01:08, Peter Hurley <peter@hurleysoftware.com> wrote:
> >> On 08/20/2013 06:52 AM, Viresh Kumar wrote:
> >
> >> That's really Greg's call whether he wants to take up RT-specific patches
> >> into the regular tree.
> >
> > Yeah.. Lets wait for Greg..
> 
> Hi Greg,
> 
> Should I resend my patches with better commit logs if you are going to
> take these patches?

No need, I took them as-is, thanks for doing this work.

greg k-h
