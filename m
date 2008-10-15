From: gyang <graf.yang@analog.com>
Subject: Re: [PATCH 2/6] Blackfin Serial Driver: Add a debug function to
	serial driver.
Date: Wed, 15 Oct 2008 10:23:41 +0800
Message-ID: <1224037421.6284.40.camel@dyang>
References: <1223891185-13924-1-git-send-email-cooloney@kernel.org>
	 <1223891185-13924-3-git-send-email-cooloney@kernel.org>
	 <20081014142701.72090868@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:16902 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbYJOC1g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Oct 2008 22:27:36 -0400
In-Reply-To: <20081014142701.72090868@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bryan Wu <cooloney@kernel.org>, alan@redhat.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi, Alan,

We are making a SMP like patch to blackfin, cpu_relax() is replaced by =
a
data cache flush function which will count it to a per-cpu counter.
If this serial function is called too early, the per-cpu data area have
not been initialized, this call will cause crash.
So we'd like to use barrier() instead of cpu_relax().

BRs,
Graf

=D4=DA 2008-10-14=B6=FE=B5=C4 14:27 +0100=A3=ACAlan Cox=D0=B4=B5=C0=A3=BA
> > -		cpu_relax();
> > +		barrier();
> > +
>=20
> Seems to be an odd unrelated change ?
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
