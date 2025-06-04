Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BEA26B094;
	Wed,  4 Jun 2025 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024688; cv=none; b=ZtOxQqA/JPcoKwMliXRDxOOZz1Q4xax2DMAA0Q4zVMd4yc6mnmbTedZGX63IjI7O5fH7AxFy1LsC+JU9w4uSDcU0Hl2xtDuaa+J5LMFzTg/uNuBklCCVCQnGVdQP2xFxWGj9mtkyTGae9IpcC1D2yT1OHd7yG419w4lXNJIkvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024688; c=relaxed/simple;
	bh=T/MaLDCc69sWgtYeEkn1C8Q0Fx3OYUU721H41ImDug8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq24P6FeVgIBmIEVrfkaR3VLMktHOftBbzEnCk4DR2MkJxid6lSqkT+rqPBFkAoUwWrtk7dbYXenGAa+LFTZTluvGzMyZ1jhJOaAsSe6J51zmMC1UglxtNujUFgVaRsLHCAHzzSs48cTw/BPhuZ/aaVm13JQ0bMqOQB6iSgFzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NH7HcVWW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NH7HcVWW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WHzBxjsH020GxBtBRNdihpHGR375f1xb06ZuyU5mJTo=; b=NH7HcVWWDTwypRgVjtyHW316n1
	SFMPuslv/eMdHYEckdjcuxLq15RYtwo7YmXwDWY+Hm9ArxMvEYnQQuXUN5MDEFqiKto3m2bBf85he
	9qPSZ+VXi0dWdAY5ueq9kVaTUD+67bxUXJaGuTMPtrn1BaExp/MaQBAEeXuAAH0255lqtkaMPD1qu
	oUe0F+mq5sTSu9I8H1QPzWB9o5kB64kCPrVABb57xebPh6c+LpnQmKrOgumGQ/cnFCJEVZJo0ZuJz
	Hp4hVmzcTcTIytZV6zvWK64IR4sNG7tUtdBX78dOM5hzv48YeTvlNbjpAKaBZX6ONz+J5S7J1NgCG
	r3pyT2xQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55740)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uMjDU-0006y3-1m;
	Wed, 04 Jun 2025 09:11:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uMjDS-000127-23;
	Wed, 04 Jun 2025 09:11:18 +0100
Date: Wed, 4 Jun 2025 09:11:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>,
	'Michael Kelley' <mhklinux@outlook.com>,
	"pmladek@suse.com" <pmladek@suse.com>,
	'Ryo Takakura' <ryotkkr98@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: Problem with nbcon console and amba-pl011 serial port
Message-ID: <aD__pjZ_o7QMbXhC@shell.armlinux.org.uk>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84sekh5cki.fsf@jogness.linutronix.de>
 <TY4PR01MB13777DAC71E234B9E58CC6C0DD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <84wm9sne7w.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84wm9sne7w.fsf@jogness.linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 04, 2025 at 09:50:03AM +0206, John Ogness wrote:
> You are correct. I wasn't aware that the clock framework had a usage
> counter to allow recursive calls. Sorry for the noise.

It's documented:

/**
 * clk_disable - inform the system when the clock source is no longer required.
 * @clk: clock source
 *
 * Inform the system that a clock source is no longer required by
 * a driver and may be shut down.
 *
 * May be called from atomic contexts.
 *
 * Implementation detail: if the clock source is shared between
 * multiple drivers, clk_enable() calls must be balanced by the
 * same number of clk_disable() calls for the clock source to be
 * disabled.
 */

similarly for clk_unprepare(). It has to be this way if you think about
the fact that clock sources are not unique to clock consumers, otherwise
the first clock consumer to disable a clock will disrupt other
consumers of that same clock.

It's been that way since I created the clk API, which predates CCF.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
