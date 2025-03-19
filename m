Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E82528E2;
	Wed, 19 Mar 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386907; cv=none; b=QcM7z6P7QhUQ4dKf97O77xO46xcMK2JmAR2XhgHvnwoeR7q4QqpXDrUjRXTutF9AGHEj1s85iBXVlykx6Wbq8tg0doM3bmW2gyhcpkhR73V+jdfkMCyLQaNN/+jddmkNZXqTYXz8rQuCrAc7M9uhw3BfklMhZJmceLn6jC+HfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386907; c=relaxed/simple;
	bh=JQXniEsEfztX8j6ooBAgw8s5V/yk+VanNbPf+6bCEt4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jb4NkURxmbBpAJZqld5ttxkAlSr7QHd4c1KKRuSCroYHg3qNSkHk3lGCJ2087RmlZTXhU58+pdLscZfQ6uhHfGkl02sO0OOFD3iIlU0ekLn1eRShgEX3gSE67jzctCrZDMzDlMWGGurkOnKhT+OmhFP0nUA7lzoHGrn10TEu8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkCjWBe3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkCjWBe3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742386907; x=1773922907;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JQXniEsEfztX8j6ooBAgw8s5V/yk+VanNbPf+6bCEt4=;
  b=IkCjWBe3792G93aRG4B2+oRddR9m5afquHD7E1kDM9U3OPqCs7aJt7VO
   os5ZNcBv2B726qwqsrRrVgwLxGjHamgHevJnDQ3KM+HdZfTqtfDRGNsvR
   7o0LAvnkDgMG/CGrhyUAkNSOG+/SYyU7Aa9yGKSLnRVDkbSjnkJERgh0c
   eZk2pDmM0hLPTRihXEGCVoM2MOXPdPsddS7yD0RfXBstcOZB797irVViG
   ILtCy/U/QXDqEtezM1mKtK/33ZKCtMtQCwxPw1BGbxs48+WAp7DBJbCu/
   D4Rf9bjV+cOmnwvAQS44vjppVhAFhUK0EyO+aBt+lgg58+E9EdUgsw0vC
   g==;
X-CSE-ConnectionGUID: Q4cZnDxQQE2o1C+1sd4UMg==
X-CSE-MsgGUID: JNO0Us5KQqGk7U0tXNKRIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53786659"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53786659"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:21:46 -0700
X-CSE-ConnectionGUID: kqE71n+dSXyrXrmgmXeazw==
X-CSE-MsgGUID: U71Xncg0SdStD2XvBMNnCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123092094"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:21:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 14:21:39 +0200 (EET)
To: John Keeping <jkeeping@inmusicbrands.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Wentao Guan <guanwentao@uniontech.com>, Jiri Slaby <jirislaby@kernel.org>, 
    Ferry Toth <ftoth@exalondelft.nl>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dma: terminate correct DMA in
 tx_dma_flush()
In-Reply-To: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
Message-ID: <c452c05a-b6ad-144a-2738-ba52d57e7eef@linux.intel.com>
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-601448847-1742386899=:10063"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-601448847-1742386899=:10063
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 24 Feb 2025, John Keeping wrote:

> When flushing transmit side DMA, it is the transmit channel that should
> be terminated, not the receive channel.
>=20
> Fixes: 9e512eaaf8f40 ("serial: 8250: Fix fifo underflow on flush")
> Reported-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250=
/8250_dma.c
> index f245a84f4a508..bdd26c9f34bdf 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -162,7 +162,7 @@ void serial8250_tx_dma_flush(struct uart_8250_port *p=
)
>  =09 */
>  =09dma->tx_size =3D 0;
> =20
> -=09dmaengine_terminate_async(dma->rxchan);
> +=09dmaengine_terminate_async(dma->txchan);
>  }
> =20
>  int serial8250_rx_dma(struct uart_8250_port *p)
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-601448847-1742386899=:10063--
