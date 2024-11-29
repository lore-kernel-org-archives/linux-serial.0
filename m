Received: from sonic305-1.consmr.mail.bf2.yahoo.com (sonic305-1.consmr.mail.bf2.yahoo.com [74.6.133.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8B14D428
	for <linux-serial@vger.kernel.org>; Fri, 29 Nov 2024 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854979; cv=none; b=FM259JkfLD/4VpRQRWpankDch53g8jvpuZkv3FrSLCKm1wwAMXfCmD+kkS6/cpGmeZQAnwoUbHOCtpWn78bMeHZeB+2f2cGOZTeu1YnDswd824XBJRoJXcBOTfeMhf9IYkOl+hx0A9l633DEfHujh0pAduPwm8kwUTPaZqH7plA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854979; c=relaxed/simple;
	bh=+/KmO3a3ZqPkpk88xYk2TASZx3w+zAIDLk4JhcnfO3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=DZoWcsG/02fEcxMYkZbS9qS2waDiwutxoCAuxEb7bdvQzSL1dK7W/W3t/3tm4NLWVzfK7hZgYGh82Mk6RUKHalVAodmz3kBJkkhSjGic7EM49V5/L4fJvfArJQ8i0TluumLDMl/OkpHZ/Q4l+71Z113Ucb7Tte25/Awchm+5qhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=HH9997Nc; arc=none smtp.client-ip=74.6.133.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="HH9997Nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1732854976; bh=GQSojATNMkj2XY8rz6LmsRqO9TSCVXvI4iHLwdFwzks=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=HH9997NcncJx8MzvDHZRRLL4ghvo45rRNcSrSFyKADaW4v0Ugh8b9/QBa5uX79FaMRDbS7MrKlMC34qLJNz2pYBg4fECWi2XZpDwQNXxjjXL+5YltB1bAHTGWs6tHS/tN/VuAfVh08F+9KtZ1B1sK6zbdug2++DSuYifB+0xQapgdO25NlYBY7Rzo9z3uKRkWHE3L3tWV/cJqyqieMWFr2HFLYsEKAGin7q+EL0VWbCQ8Ac7KDzpRsfl6fZEELbayW/b/FEZhC/oOgM3gILOI5kV7Jzq6QPPIp96Z8nPPtrNoSzDNhePuOn3+TbQ1UgYd4YHDIx3qsVjUusNTxyhSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732854976; bh=7RzgHPwIy9OGQj/sXsANIsXF9ePijAbvmwU7JeUxUDE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SsST8VcpU79fBDWd7LJEVpp0JtnIjULj9BhI3o5ZUDCnZDbnAe8c33LDlcVddIHSZ2WE4/hVQaafterL2weB1Q2+N/4joqFLKGqmLM8Aipz3O2GeuKNebqv5JW9cSojEPogtzTCUUri5TBYU2UndkOmV7PJUrSo/CAZJjkT6Z4Ko5d3LMwxJfmDrMPv/9hQWoq6o3w129yC7abCa7CuooumtEojRLFnKyaD/w+2ZYeUqEXIoxCsXlssnxA/F3q5EkLgNi37hhSZjnMidPR89ASsCpwOcqQBP7tetL6GweeR0jMjcGvcpfEVRiI1rrsJuV4Za2tLt5bx9liNNT1ZvIw==
X-YMail-OSG: AMSU.RMVM1mb6bKRvoYirGQKxOZVMJWCgdDqu5v7FdoEhWK8eIccml0v4EFSHY1
 JU5RphcaVbkv10w0R5D_JTx67NbJFP1zgo1dZfssY34mnvwAY3xHGuPTTNoQ9xJC98XZp3N9Kf.e
 3hPJoJvewqy69HIMKGVFyVWcPmSjEyiPJRTKpmLjuMUJQP9tqfm2Z7QW18.ejM1ToJqldGwXSFf7
 9bfi3pVlBFKf_K.xAxM2TsWjc.UkFA6ozUeruAl4WaTcMaDoBq5ps3sb8LHHFYqxX1vDzZ3hUFrp
 0GuXSmPzrb6dRsRtpi29VrZGIaGt1_3ISPuPSgnxz_3hZACJSkwOagx0VntM4IECaqSeRSIOBqlo
 ax.9y6YA3.qX3q7hGF7_KHji4nI6Om6Ae4TCaoshiOdfsdAlqlaigNl9HchkdZFkHA7eIFiDKLQI
 jjSzlQmOJ6ptipPS4zWcM76JHAaP5FLJMZoCrcZcs9zedbhhT8mjtkoef0hrxZ2_6Ik83XePo7FC
 vZMIrVGtaeHFyOR7iIgOpS_li_riOTfsQlDpqFFlfUolP6EvYqM485dEXFX3oqegD8jG7ogNWQEt
 OfxR2kHYIDGgtzF4.12AEgjlQNkXr9TgvHwc3RXK3nRcCKzYypscGesYW.KgoeV74qxS_BPiQ_DH
 2F3Wa2UhHaKMAWIC9SxFfO2zXKTH7pDkaaf57wPzzWYb.T6qFpErafTrAWJ4cVPtEJbr4qczudDW
 YevbO2pxFdbP479PElYGWPeAGOR5tR6iFYdKsltyA4d9qQPsR1fLci0cU7PsNyeIIAR1N_.HdHhQ
 mZ7SXkqjZ7diL5T.pns1.cegBjDWOGJRcLcr8qyyNW7xFCLAvIn_2PAOyIKu.g6aEqRYP9G1v19p
 uSytSUubfFr.fWw1wt0i0_HXR250QIVCC.AVBYD4nup20m4Jdu6WIrkPcfWkDD5_iBG7x5RlIWml
 ceYzM6NBIwGoTi3xFHuL4on1adsmfifarkhOFZZz2wMfvk3YJ.MnynMMpHKfBMrZ5j8VqCHb13vr
 NG7qZCuGnxytJrP837fsfaMBtvVSSIZ3IL1wqtgTtxA2G8i_sCZ2y8Ur4UfLnU_OWHj.fHKAVmRs
 BWpIhPr0dvuXYYU5lqvywS.MfAi2FlaeTgOdlMKiGOCqZScGc7UdzA2gkd0dS7edzD22_tZ4qTFw
 w6DOSJsZZEhjOtNRuOuth9dr3RyM2jiIjBXyjpJ.OQF38mjQTGgsMoreJSQr4ZvRdueQI9qQmd9p
 XsqNPX1qxA5t1HDZbLGyPnlY3GK1M0O2kVXnBF4j4AZ8Gx3H6jxRf2OA01jl7wujvo2RraPvTina
 by_qwjx6lswZiv2YWhuHGz5BBny_0GO7..FOHaD25QjYKZsWyTTyYEYCDXfcozo_QO06DLHcxsQG
 Om9ovVPBlRVuYRpj9s5HKVGA2JMwgcGMJfXUmcvaMPEr32tCo06v8occKdJdn4wOEnPhqyjoYoL2
 ODoHtfITzvkkrIMtO000OpcD.jRm.pYp1yrfdwuvUDyf3vAP_fKgaNeRYp09oTu6nAZvIyrRYraY
 ktkPKVfItlPhAgnMz7j6_q6HSKKdBXf85eWknX7rvk8wuXGiTLIaNPr86yemciv5ud50yfK8nsF2
 SwPFb4d38wTOIvd9UPgLaQ0Nsn_6lo04khs9O7DzmIe2G0Cft3M4lqob6JNiw2jNeiFgPehLQIX4
 uySRzYDwO4wgkfYtxx5CWWFhmWwoeEaT0_1SQRbe.ru8erdwbkpa5ui5UeUeTtRQmbrArEXpQVPI
 lLaN1Mn.xIakdySoWc8MyouSnoGOc0Nj578WY93CTPQtXFTL.gi7ttX9OQRmFdkITdRRXXev25Eg
 viWaZWmCWq49JanPLS7FXm5TaP5WAuF1H1bhrYP3buNUS5J48rI8B0i22R3mhgM.16JLzTQwtX1p
 kd9MV_xf6mhmKPp0InuFPZHDNhKaUq7qgSTm88HJ1W89W51OgF58aINB6EwPf33Hiwaqz_EXQI0o
 BJWORXxAlcA4aoyBdoqqEwRMaN.Suk6ZBmVPojXEO4gQlOluGfWApxlOaPIKp7Di5E1Ee1IJXixr
 ThkEFHCiKihwaxHCNfTKF8.u_6hpBc_iC9Yh1rCDxhIA.Gcz.27VfiVyS5_71NB.RVJCAIMfxsXe
 _KT83YdXKEBPJ9Xl.yMFzjjpMPN5gaoZHcpNu43KnOjfASTGuRQHmALJU_TfeL0ezmLCqrtNZoOo
 qSmaNopED3kkD4BbubDcJ4EJ0EbKnNnDrnhU74be8z9Lbq_JplX9JnqEpLbpVQxCPBViZnhlb3L1
 WU_dbo9zh8IMi
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: b678fd99-ae38-49d4-b635-e51f217fb12e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 29 Nov 2024 04:36:16 +0000
Received: by hermes--production-bf1-66bb576cbb-h2pjb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af1c0b40292d512b9d850181f2953147;
          Fri, 29 Nov 2024 04:15:58 +0000 (UTC)
From: n3rdopolis <bluescreen_avenger@verizon.net>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: n3rdopolis <bluescreen_avenger@verizon.net>
Subject: [PATCH 0/2] Optionally allow ttynull to be selected as a default console
Date: Thu, 28 Nov 2024 23:15:47 -0500
Message-ID: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241129041549.778959-1-bluescreen_avenger.ref@verizon.net>

When switching to a CONFIG_VT=n world, at least on x86 systems,
/dev/console becomes /dev/ttyS0. This can cause some undesired effects.
/dev/console's behavior is now tied to the physical /dev/ttyS0, which when
disconnected can cause isatty() to fail when /dev/ttyS0 is disconnected,
and users who upgrade to a theoretical vt-less kernel from their
distribution who have a device such as a science instrument connected to
their /dev/ttyS0 port will suddenly see it receive kernel log messages.

When the new CONFIG_NULL_TTY_CONSOLE option is turned on, this will allow
the ttynull device to be leveraged as the default console. Distributions
that had CONFIG_VT turned on before will be able to leverage this option
to where /dev/console is still backed by a psuedo device, avoiding these
issues, without needing to enable the entire VT subsystem.

n3rdopolis (2):
  ttynull: Add an option to allow ttynull to be used as a console device
  tty: Change order of ttynull to be loaded sooner.

 drivers/tty/Kconfig   | 18 +++++++++++++++++-
 drivers/tty/Makefile  |  3 ++-
 drivers/tty/ttynull.c | 16 +++++++++++++++-
 3 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.45.2

