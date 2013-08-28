From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Tue, 27 Aug 2013 20:43:08 -0700
Message-ID: <20130828034308.GA12481@kroah.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
 <52123A44.9090608@hurleysoftware.com>
 <CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
 <5212D602.2000005@hurleysoftware.com>
 <CAKohpomE+6fxwF4JsDUDCzf+LsWZ_deBsRzF_XYjQHZTPvp_jw@mail.gmail.com>
 <5213C5CA.7060206@hurleysoftware.com>
 <CAKohpo=rZn-0FwcK5gzyYXufpVvfFHXSz_bK0=EqJbTDNcxqMQ@mail.gmail.com>
 <CAKohpokL4_RZ7s=yyn8S5jKh5zpW_DaUK4ni5_x_qN2+0Bv-Uw@mail.gmail.com>
 <20130827231946.GA18233@kroah.com>
 <CAKohpo=aoHeS3etLeLCmp6w=dN1t9RQF0Nw3oA+VCKLY6w-_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44374 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab3H1Dkt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Aug 2013 23:40:49 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpo=aoHeS3etLeLCmp6w=dN1t9RQF0Nw3oA+VCKLY6w-_MA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>, Linaro Networking <linaro-networking@linaro.org>, Peter Hurley <peter@hurleysoftware.com>

On Wed, Aug 28, 2013 at 09:01:25AM +0530, Viresh Kumar wrote:
> On 28 August 2013 04:49, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > No need, I took them as-is, thanks for doing this work.
> 
> Thanks Greg..
> 
> But I think the current commit log is poor and doesn't communicate the problem
> well.. I have prepared another patchset with the same diff and updated
> log (below),
> I can resend them if you are willing to drop current version and take next one..

I can't drop them, I could revert them, and then apply the new ones, but
that's just doing 50 patches of "churn" for no good reason.  I assumed
that if you really wanted the changelog changed, you would have sent me
updated versions by now, so I went with what you had.  :)

It's fine, don't worry.

greg k-h
