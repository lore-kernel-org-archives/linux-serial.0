Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6F2853F2
	for <linux-serial@vger.kernel.org>; Fri, 16 Jan 2026 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571672; cv=none; b=d/lt0bW0MvEBdk+jFEFLTd6ONX05mYp4p2RJM2ZMeGS1gidosWP0YRs3k9WxoqgUCNTKtyu5flLX6l7YeA6DZ5+ZdhcPWQtZy6ni9M2aJo3sXlqnjx8NmNRxMqMD+huKX84L0ct89KIl4jifAuaivTzf/NlcQT+G3/ZLkjewtjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571672; c=relaxed/simple;
	bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOH1pcPU+L4ZRYY4c0Ghb3PJ38FWRKN/PTTxCSy2DMVdlYXZ+mRK6lv9vjO/w/KmT0oTaW4ebYJlvjXgCTuuXCqHAaZL5qtVtPWCJTjfCANLQRYYV39oGOPTGFrqT1JSiF8VDZFqQqjSv+ejhdcfRR7ZgcN/KbXiyeTsa2+sfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K9BQh4a8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K9BQh4a8"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc544b09so1465853f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 16 Jan 2026 05:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768571667; x=1769176467; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
        b=K9BQh4a8aZ5mcKvc22cHMHLYT6xwWRlRDeFBc2yLrCgG0AD47CVxTHoudVy98hUYOc
         8bz86qaXlX2ZPMbs6RD/y5QKpWaA2GaVWL1SlttExDux1BkhdSSjJGj5/ElT8LfTRm0+
         dj11njKu65iXAGj2QJJmrd4/HlC/cezwhU90d5bCTuuOxZZguFikqJKi4Zt3Q+he34s/
         x546B1I5RhsHx3bVNBC5pay8PP+oIJKrC3sfGWazehRAVlttZgr5xF9YLRMrNBHA/fzP
         SOvipZeJoypOVTD+4P+zmxHD/tNOqnJRl42CfhiuvQllYWg/t6psKMiZNwSnWmO4I2BZ
         kWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768571667; x=1769176467;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
        b=r+8iNMwXBtaFbVlbMK6/GWi7YrGPBHvx5UuKJbrh8Q9nm3yNOZC7WlDwYF5jsOygov
         jtnQlIX03sBE4x53mTTp2rlxt0topJuRxxuLgsbVTj1ErQYQbCh4mb0XTGgfYMH46qVr
         OjdcBQMtQY/43+8mr5VXDweVk1h7BcOgzL6Dyyyt4KCH9ZAFkIOTbhUiZY0z9+d2wwZB
         +BjC2SgPun59FR+fiLd6RAhidt7/agjfMTy8bGok6y/hmN5rGdxf3FAdtcXjaYpIWzgs
         AIWUjZAqIbrkbLnloDiSzj/pPdUc8qvBD/YIPc3tmUNrOkWtYrlL+e/5Hehaf3rI55xk
         N2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhQNGOW0dchors6nm2kloJaDxHXDuibukoAEPxC3Ce2UkEixrFMqHblcb+uxBnsZqjfMxfWCcIZSqg0Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqwtUmhOvpNmhU+efyMdGcTdj3q8RUGtHTKT8dfXL1N6W5NuO
	lks/svGYrDbpHDLRZX9XxgoZZQCEfuiVc7Homvided2YAwx30XxXo7DrvA3hjoGmeMk=
X-Gm-Gg: AY/fxX7OYSDfQKWP+WBhsUHmNxqtg5EkPbqVt7Aqcvh1RX4itVqfU1dxifE7pwxeEvL
	NoyPIY51WPoG3f8ddwY98fxc8jT77qTJKZVd2g2iSOEYjLdmaOG4E5yahklkySpGBmXGuzs8DzY
	g3zD2qqQragnE/HXoATVKB/C3Y4hs4Bcix7BqZRpPTyNgr3K4yA+ahO8EnnaqdyeaI9Trez/spU
	9UD4PAqf+vpsWUGT8TsR7zFyB2Ijn5dmvDCYGiWdyTraF89uT23yv0w29C8n+jjqZ5arOpesL1D
	VQ946isW3BY2JqojKodWpaWMMwGNwN7pqLvBj/QdrH+LgEBjGbOAuHDBVWrFUJmN80V/eL9rMmM
	/L3RoqO8MljVdOmgJ6EhRfTts0VVRcJzlEMxxldSl4Go3uEdjFKVkPdPPOUhYV87rHpuUEXu2ui
	MOXUGglm/GGcHj2VI4pMr0Jk+OwBd+h7qLO6Y2yk8=
X-Received: by 2002:a05:6000:4387:b0:431:1ae:a3d0 with SMTP id ffacd0b85a97d-435699810a1mr3695386f8f.25.1768571667158;
        Fri, 16 Jan 2026 05:54:27 -0800 (PST)
Received: from [192.168.3.33] (97.36.160.45.gramnet.com.br. [45.160.36.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435696fbea8sm5433542f8f.0.2026.01.16.05.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:54:26 -0800 (PST)
Message-ID: <6168099632390068c8544b48f2e81bf737aa10d7.camel@suse.com>
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson	
 <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jacky Huang	
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Laurentiu
 Tudor	 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Fri, 16 Jan 2026 10:54:14 -0300
In-Reply-To: <83zf6daetu.fsf@black.igk.intel.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
	 <83zf6daetu.fsf@black.igk.intel.com>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 14:04 +0100, Alexander Shishkin wrote:
> Marcos Paulo de Souza <mpdesouza@suse.com> writes:
>=20
> > The register_console_force function was introduced to register
> > consoles
> > even on the presence of default consoles, replacing the CON_ENABLE
> > flag
> > that was forcing the same behavior.
> >=20
> > No functional changes.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks Alexander!

>=20
> Should I pick this up or will you send this with the rest of the
> series?

I'll need a v2, since some things will also change in other parts of
the patchset, so I would wait for the next version.

>=20
> Cheers,
> --
> Alex
