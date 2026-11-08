Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104879;
	b=yP4JFefrCrXNqOqFppwrt9VDbDy/2HAnhcwxdk/HFB4fui44vaL0u8mut2ch8hjdzgOt
	 pfMeR6LezfVPZ9XUnV2lpgqVIAmH2ZslN8ZnServ+cYtifkbHHm+PH1ANotrsBmQk/rQc
	 6qVut0/CFSHwO3DaefgnTWsZ2hA2IyzCjw8v00mSwXZ2wpicVVdLE+hdNvmwGOF3yQzg5
	 eoy2xYd/5VfrHcMDL1Pm95w7rO79I/wkJsI2AeUJOR63RGh4m/H8joq+2XXZveaJuujtU
	 FRYy7cI/Szu1PubEwQGN2q0yd7oveMUTL4987t0G7ImUNDR4yqUqu5WjkkgcomVvy1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CgFyMsoiKO2B1HX2AvfFumGFOpktUiaDt0kSWOji51M=;
	b=BuQpGHJ8G/zREP5mlxQ7XLvtg/NGs4ebng4y19bATE67G3nHrQbg+qEcFFu6LXO1QFD+
	 dLPnBxGzz+Y49OjnzjDPtkBasCG8e7/SutKj9KZK0kPQskYviRVilcm/AiWTUVxDPH9HA
	 oPGDrAAxsxJHeivRUoJhbqUHF5+IPPjg/H3Zzdke//GxCBEciBkDWVCVSsvH45kSTtCta
	 uj1blOlz5tbrWFMO6eFX7+u0SoddGu0s+jG8ibjzSFJ0rBQECtGqaQ7nRb2L4dxYZPstE
	 fvh0aN22etFF80gxRQ6Xfzg9nyfsmalzoaWs0zsywLG6TMa/HjmEkt+VPJHshCadbTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Crtt9KFl;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1780606A31E
	for <linux-serial@vger.kernel.org>; Sun,  8 Nov 2026 02:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1780606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Crtt9KFl
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37000e7234bso512203eec.1
        for <linux-serial@vger.kernel.org>; Sat, 07 Nov 2026 18:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794104878; x=1794709678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CgFyMsoiKO2B1HX2AvfFumGFOpktUiaDt0kSWOji51M=;
        b=Crtt9KFlMLRjcguZk1VYPvhTgDNZMElzf0tf141OxRDD0nRpz/y1O2me5bx5zPEHRw
         DOcFer5e04/3lH3hXFl06ApuJDKLG77CFSixsb0t6MlRt5PwYzLnVHXQt/lmhfJSUCov
         8/IoZwOneMKYGudlQKvHL0tGwwIWFHD5bmHdaSx2Aca7D6KfUw3p0kAAsMbidPHSH9K6
         Vtd7DUJBiDizA1z7P9/HbJj4YxUHaR6Y20nKVwijj6Y8lmutdnjW1IMT8sE8avgxaW3d
         2oCXfkkFNdLeVsQOzUyKG8TFQRCGvgtR9ixvehQM1zvDECpHHm1ePN1spXa/oKXtzuE9
         +A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104878; x=1794709678;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgFyMsoiKO2B1HX2AvfFumGFOpktUiaDt0kSWOji51M=;
        b=XUB2p3XI1VRNfO8jJ0w/7NmyeZvvnOCfMUr2XscypzLO1gxI1pt30rOZZiIZ+o2EwD
         +mtejimdndsu0rHPoSAQkS+OgeTmHg/xKOFiY5g8VfyAaarcMJBNIfSxgXeyiG9Mj3K1
         T6I0VdcOVvsxAMlPmBDEj8pOmk2sju8FkK+M7/xYd/eld/K+Wc4GoXpoAWdmNUuQDek3
         WCD31F3k78KFt9B5E35yqCE+Im1vrFzBFW1X9NxJTY50AECwKNnuzy3v+cxwc4zUtaDo
         XWre2nTqr6krU5KjD2xc0ZCG3ScPZAi5mNsaebhi1ThS2II2SHIuZp02ygXo5Ebx9Xpl
         CW+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwx0jqSzneyXiyiK90/riL5voZhIDmOTctM2v/TG7shWWOz06h4NcKRNALIFKnHtPMWqo1oCMWWYeiVIww=@vger.kernel.org
X-Gm-Message-State: APuU4Z81FYHRHmfjtBMRHXjwdIEIPYqaAhwlvwWj888R+iGh3BU1fG+a
	U4G/e4wXfFWGkpNFm1kPKetNfrO5tTCrLVLmtFYgLVN+/rvHzfOjsSwg
X-Gm-Gg: AYBFou1uT++uuXMo2eexVCZ2ZiUcuY8/75X4DzDq3qTGAEzwV9haCDRofthlW0KAWWt
	oVmgG8gsWBuPSObvptgrUhvxUORtlb38CeWw4giuUiCdphkdswhlfZGMlC/teMaLcxRK+CQVKWz
	bkcZaN6RiTEYhpdTG2iEgXRTOtUFlv9cDNEzwtZdtBKHRmpilqFtn3l4NPAGWrxZ8tXP238Irbo
	9JUH0TwX+5krTienYEtFFNskJwrCnMUlwJNQPacsaTTC+Lw3RmILBeD1RxF9yAZl0Fk1GVOFTWj
	Pum5hlZozN8sa/0oBwca1gzdmUqW2J7XsJoHdoyZhkPwDQ3CneDdmDbh1Iq6BSq+yTMrJbbqySB
	a41cyBFWa5UqsO39xybu0fWSe/y1Qs15kPsCHt9QUvdlwF99NSDUHRCOif8HkFgDdIe0AKzBZhl
	xyxpjd49BL2766PFRF++FTOAM+ORZUNrzbqQvwZUEmEl/xW0d6nV3RCK+IdZrm3AFqfi7yHG4v9
	qSb0Mld17tYFtECJxmbAjFUjht+CTiJXXXQZIlf6XOMY/CovTfRkp5RytH8hAkL5egqkG9067n0
	xhJg9ECCu0jI88A3MTma
X-Received: by 2002:a05:7022:b0c6:b0:190:d0d9:3110 with SMTP id a92af1059eb24-1b39ff2dademr463410c88.45.1794104877934;
        Sat, 07 Nov 2026 18:27:57 -0800 (PST)
Received: from debian ([169.211.140.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771ea85bsm2390172c88.18.2026.11.07.18.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:27:57 -0800 (PST)
Date: Sat, 7 Nov 2026 21:27:32 -0500
From: Kwanghoon Son <asdfkwang@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 12/12] MAINTAINERS: Add Bouffalo Lab BL808 support
Message-ID: <au_eFNCt54nlCafy@debian>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
 <20261029-spyglass-evasion-772697094cb9@spud>
 <20261029-amuser-savior-6a6ab062f471@spud>
 <auSDJH9V31wmbrYv@debian>
 <20261030-slider-finished-360b10521e0b@spud>
 <auXQaY25XfYzxEb1@debian>
 <20261102-throng-botanical-b244058ecc37@spud>
 <auqC9jOIQTyieQUJ@debian>
 <20261106-dislike-despise-91106ac848dd@spud>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-dislike-despise-91106ac848dd@spud>

On Fri, Nov 06, 2026 at 06:00:13PM +0000, Conor Dooley wrote:
> 
> Cool. One thing that I noticed, and felt it was a bit odd actually is
> that the uarts are fed directly from the crystal oscillator. Jisheng had
> that in his original series though so I assume that's actually how the
> hardware works?

I carried over the direct crystal reference from Jisheng's series.
But will change in v2.

UART3's baud clock passes through a mux and divider. The current M1s
firmware selects the 40 MHz crystal via MM_XCLK, while the APB register
interface runs at 160 MHz.

Following your feedback, the UART node in my v2 work now describes
complete form of clock itself.
two clock inputs:

clocks = <&uart_apb>, <&uart_baud>;
clock-names = "apb", "baud";

uart_apb: clock-uart-apb {
    compatible = "fixed-clock";
    #clock-cells = <0>;
    clock-frequency = <160000000>;
};

The fixed-clock providers currently reflect the firmware settings.
I'll add proper clock-controller support before submitting the DTS.

Best regards,
kwang.
