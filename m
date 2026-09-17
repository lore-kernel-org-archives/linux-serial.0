Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF084AF17D;
	Thu, 17 Sep 2026 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638038; cv=none; b=ieIzouBmjJc9hd8fwLMu3RAZ+ocag7HgfNdfAalSU7Q4SD+ns9UDDCqKO+m4CZbwrFgnwly877MbBnvdB12goZx2d9ypTpdOxC6c2zVzmrQe5qc6oWtYFKbxwnJDKr+W+6c6mp8h00VHIivkhz/eWwOWHfRebM3RrsLj43zMRHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638038; c=relaxed/simple;
	bh=otscT2bXzD83gojmGmTLeHkZXz5lfo5b0k40UfqP2rs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SNC9g5eSnEiI0pQVJIgeHflyf84xFYG+AuysTUbJSgohX3AiW4fsdL5dkhDcYWi3ttZxwrKXzo0RKYvl9x1a5SBQZQ1D0TN/C8JQ65L82IGdf+NxSf0bzvCchhMYNoQ67L+E4gDyvlQH+k0F7HzaVYveUTq3q7okIjEk8zsBld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Km8DvUPR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Km8DvUPR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789638023; x=1821174023;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=otscT2bXzD83gojmGmTLeHkZXz5lfo5b0k40UfqP2rs=;
  b=Km8DvUPRWEkKvbBP3LABcf7lX4DWhIcVBeKxp956dmqgx0OlS5w/pI4L
   OaT2666SKyPnCnUElvon0DtzdotiQT+tfGEm2fbmDQtKj70tGiqiHas5Q
   ZZKRtlP/b1yT9T/yBmniZDjDfGNEb7gNo8GUIEvb10635Po47cug2lrmZ
   aP/nQwZAGxWb1AqnOvIee1sidLVLDPlLaejIj0eRG86jn2CDGW9NNjGkI
   Z83gRW2uobHr03Yc/IpI+sEqdVngYlmUjXDKcRvkzHR0BlC7ETo6wa9z0
   +i5/f2FJc9Il0h0GkWQLsjn5UzvkOsrVFTuv+s7YFV0WwL8sR5YSifmj/
   w==;
X-CSE-ConnectionGUID: PHxZjuJNSfKO5PjbT3U5Xg==
X-CSE-MsgGUID: rqPgDWZZRiiibPcIBm09Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88978140"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88978140"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:40:13 -0700
X-CSE-ConnectionGUID: RR7/wbawSWCXYUy6RQHLqw==
X-CSE-MsgGUID: Z24XUPyeTVm+RLqqb8feXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267459668"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.62])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:40:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 17 Sep 2026 12:40:03 +0300 (EEST)
To: "Kumar, Udit" <u-kumar1@ti.com>
cc: Moteen Shah <m-shah@ti.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
    devicetree@vger.kernel.org, gehariprasath@ti.com, vigneshr@ti.com, 
    nm@ti.com, a-limaye@ti.com, y-abhilashchandra@ti.com
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add capability to skip empty
 FIFO read
In-Reply-To: <5801b899-8090-4bff-b4e2-c3e8c97b0eb3@ti.com>
Message-ID: <d82f9326-6a01-2903-a1b7-b1617ca85db9@linux.intel.com>
References: <20260916085520.2259420-1-m-shah@ti.com> <20260916085520.2259420-3-m-shah@ti.com> <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com> <5801b899-8090-4bff-b4e2-c3e8c97b0eb3@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-103868912-1789637793=:1179"
Content-ID: <4e6b5e4a-82fc-095b-2c9c-81969daa9a3e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-103868912-1789637793=:1179
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <614b9fdd-f3fc-97ad-4087-6ff3cdaa021c@linux.intel.com>

On Wed, 16 Sep 2026, Kumar, Udit wrote:
> On 9/16/2026 4:22 PM, Ilpo J=E4rvinen wrote:
> > On Wed, 16 Sep 2026, Moteen Shah wrote:
> >=20
> >> dw8250_handle_irq() does a bogus RX read on RX_TIMEOUT with no data
> >> present, to avoid an interrupt storm. The UART core also performs
> >> unconditional reads on the empty FIFO during startup and shutdown
> >> of the port. On the IP version used in TDA54, that interrupt storm
> >> no longer occurs, but reading an empty FIFO instead triggers a data
> >> abort.
> >>
> >> Add a new capability to guard against the empty FIFO reads, avoiding
> >> the data aborts.
> >>
> >> Signed-off-by: Moteen Shah <m-shah@ti.com>
> >> ---
> >>  drivers/tty/serial/8250/8250.h      |  1 +
> >>  drivers/tty/serial/8250/8250_dw.c   | 16 +++++++++++++++-
> >>  drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
> >>  3 files changed, 25 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/=
8250.h
> >> index 77fe0588fd6b..45e13c3a8c14 100644
> >> --- a/drivers/tty/serial/8250/8250.h
> >> +++ b/drivers/tty/serial/8250/8250.h
> >> @@ -86,6 +86,7 @@ struct serial8250_config {
> >>  =09=09=09=09=09 * STOP PARITY EPAR SPAR WLEN5 WLEN6
> >>  =09=09=09=09=09 */
> >>  #define UART_CAP_NOTEMT=09BIT(18)=09/* UART without interrupt on TEMT=
 available */
> >> +#define UART_CAP_RXFIFO_EMPTY_READ=09BIT(19) /* UART needs LSR_DR che=
ck before RX read (TDA54) */
> >=20
> > IMO, this define naming contradicts with the comment because you=20
> > effectively say "capable of reading Rx while receive buffer is empty", =
not=20
> > that it needs DR check before issuing that read on buffer (~ named exac=
tly=20
> > opposite of the actual meaning it is being used in the code).
> >=20
>=20
> I echo your comments; the naming should reflect that the IP does not
> allow reading an empty FIFO.

I now recalled we've also the pending RBR -> SRBR change:

https://lore.kernel.org/linux-serial/20260908141524.20302-1-yang.yicong@pic=
oheart.com/#t

I wonder if a similar thing would help in this case as well?

I understand this patch covers more ground than the SRBR patch but can the=
=20
IP used in this case read SRBR without aborting?

> At the same time, I am thinking, reading the FIFO based on the
> UART_LSR_DR bit being set in the serial8250_clear_interrupts and
> serial8250_do_shutdown functions.
> Do you see any side effects to this?



--=20
 i.
--8323328-103868912-1789637793=:1179--
