Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iG0I7WkE"
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 14:51:01 PST
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5EA5;
	Tue,  5 Dec 2023 14:51:01 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 54659C0000E3;
	Tue,  5 Dec 2023 14:44:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 54659C0000E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1701816290;
	bh=N/5EsHwgAlhc64s040hv95c43o21mJukY0P77MxS0RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iG0I7WkErYIcrd8KjW3JcmJhd7NPWi20VYsNgrzUoOu095FjWST6Za3C8MIv1Iwni
	 O9D20Yzm2qDZpLJWn0Lrj8qtvFXXqep7ZQtXnzL2MgU9juCIHlOzyAp6oa5U9VOejr
	 4vPAdq/L6BqjHfydm2gq7V1MC5jH0ZR5hO/e2bnE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id A588318041CAC4;
	Tue,  5 Dec 2023 14:44:48 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 2/2] ARM: dts: broadcom: Add BCM63138's high speed UART
Date: Tue,  5 Dec 2023 14:44:49 -0800
Message-Id: <20231205224449.632075-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122144208.21114-2-zajec5@gmail.com>
References: <20231122144208.21114-1-zajec5@gmail.com> <20231122144208.21114-2-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Wed, 22 Nov 2023 15:42:08 +0100, Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> It's designed for hardwiring Bluetooth devices to it.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
