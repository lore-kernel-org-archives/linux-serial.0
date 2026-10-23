Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772504;
	b=AfAl/O/UwWIAueLmXWcb4Q7imwZsICEHyhVlR7/IdDeLXJ6D8+8VI2/BIv4IJPmc8Pyf
	 uItYxggUJv59djAlPXUCnYIY6ctDkU1E9EeXm4fTdXy0Q8Dh+CoNWUfv7cdIdTADRYvEG
	 w1t1jdGWtenSBF+ZIkBttGDDIz9Xec//agi2nuxuu/okXDX642IQ5FbN8UwOBYvnSntk5
	 icxZY4f9URrQ/E4yrrLl/Tds3gE9ALNPlu+T6mhcfRRVlGmsszgBedTivXTpCVhdHaETQ
	 u2Pe37xUfjspE6pswSYT7bigInM/RBWyc/gUCATr/ZKgKUYk4WCO0IvizxzEPnMPhvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ObpDvAOX1klXfqsSNdhdP4hJ47WYvmcb7PIfyXC1CRw=;
	b=yvZLjIyjZ2mBjV6CQar6DJLIan65yahd7NtLh5tPLSGMvfkCwTFOkyuknPVxEz05BIhG
	 xtFzqxqoXw9QJS4YThgNQVw/TIVq76EoGSfB4gLPEdXE6LTg+jFVrWAbbgLp9TMkDkZA6
	 fH8ft2y/pgArelZESojKroDJMw2YHtmVOtgQW+epc+eolDdDKc23w85yRBJ6tHdVlp64q
	 V/sTW1RC4PwRGUYroOCDNh2FTc6OzXId/+tjuv0G4E6/Gbry8vmkM9eB9AzPgbSRbc9lU
	 Hjr3iDFc950cQBU7leITcaw/l026NH1ng88XQySDQ7jtnx5/UoZrpjW/tUeCbuFTlFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhBIX0dc;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D98606A31B
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 16:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93D98606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhBIX0dc
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-487049569b6so643256f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772502; x=1793377302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObpDvAOX1klXfqsSNdhdP4hJ47WYvmcb7PIfyXC1CRw=;
        b=qhBIX0dcQktnNgcuhUOneFmHnNHKpxg+fYyk/FDPz3ae3Xmty8XA9sE9NJ4+d8lNC2
         ubukkbO61AOfg50nn/TawWQ22v/v/uhgB/q79lB1085dthU9oFX8QUCkem7s53SLDra7
         9xNt6zmk+iS6vIgX33fVpkylI56664RooxqhLUp4Ljcxz5ZjikQeNCpwBr0J7y+R7cy6
         OvPIKf3vkIdMe+0ldpc8O5maz3nEGV/qAq0q5KOT+x5x7Bed3TeV3b6OHgC1KzgkmP+H
         QzUjSQyigkx3VCU5aDPu0ZliEEO4CjZHH2OBBURVgloB6/+5apqO/Qu++l+c85QlZZxZ
         gfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772502; x=1793377302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ObpDvAOX1klXfqsSNdhdP4hJ47WYvmcb7PIfyXC1CRw=;
        b=inl4qknJyzSvgg8+jGLHyHUZ+h737cH4e9Vxch59gRPoQ2tFZVtx3iSlwaYv8dBzgR
         48GowOK4Y1xJX4ifPoHF8lA7BH2p9mEhbLt4LMd5gncqN6wFf8Q9bXzxHPwRilNG4sIx
         LcnmOX+cNFpRe/qHTDx1y/A/geBYnbYtO2AebEe/b0iYlUnaOv5trQ5PJHhXSZiiuQsN
         2mBxFd75Zaf9lDavw9xigjnAYn8nCgiaFFooIx9oT7p9s6F64XOeL2zNjkZCBQ3UvcqU
         QCxd+ARi3v9vqmBG2KLnaRpbiY1UtL8PnQSha6fPJLL1E0LzeNl9WBbdKSsfXj+zwHB/
         NR4g==
X-Forwarded-Encrypted: i=1; AKwUvBxxohy9s7wATwyiiPmhme4gH0oNL3UyHUWtrVl9ThIckhvDbLgvnMzPdKCINAHbtYxpdrcXcKbkvg7aPNY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsiHjrDqa4fdSRk5fTaIWSsm5OLo3KS253BwlMY/kcUmdXzhTl
	OPploK5eI2BMdsNipJgGLEJ/bvCFQe32x951KXISpbga5yi0uv3kuElR
X-Gm-Gg: AYBFou001JsvG6nVMb9AL0+Vvk3Kei/qpJC7PqILM1dExPbW7yPUUcQjnvfAlx+LGA0
	7CWusiwIwdCLys3gZc/pfjP/z5zCQtBORQYPL8a43h9cP/rawGlTdz/1cc6hlIanfu2ttzQ5EET
	WkuyUnT40ikCZjRV521UYLtzQZEnQpf1/k/00Ce3mFKNcByWgK9Dm3K1RkkJCI+U3kB75J5e2gT
	TVJ2262FpkNBDES7X8TQyMyz5lh8rLkFgaI9SM7ezx7izKHCEaPNOJ+cGDWD92GaFdC2IkfspWK
	uO/G0Emi3QQl5KNxeXEbHZKIx3y6hZeU8noXP3sOC4sUgWbuqOoMJWcGmEIN5HlvTv9vSVX059J
	NhFBFotSSs2sFr9ear63CQSm+LKfks9UQUendre70blgrP1NKHZgv9+BmbIUaOBf+jO+Q69eoHA
	gXuA/UL/RMA4HMk2ViANC4WGXiIkeDbja2fQqy1mlTuaQvCFC373jYjrqjDq6xkK7ePUY/MkDTh
	bUDFKYtEUKHDwyXhXrklEcy2wH3LucJ3ULAjqHON9rxF4BsD369JSKkVerufA==
X-Received: by 2002:a5d:64e3:0:b0:487:106f:ee31 with SMTP id ffacd0b85a97d-48e385a6690mr4354135f8f.27.1792772501780;
        Fri, 23 Oct 2026 09:21:41 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm901583f8f.8.2026.10.23.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:21:41 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neill Kapron <nkapron@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-usb@vger.kernel.org,
	Brian Ellis <brianellis@gotenna.com>,
	Johan Hovold <johan@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aichao@kylinos.cn,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev,
	stable@kernel.org,
	mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v2] usb: gadget: u_serial: pin ports while TTYs are installed
Date: Fri, 23 Oct 2026 18:21:39 +0200
Message-ID: <20261023162139.3308-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022091359.1187468-1-krystianmkaniewski@gmail.com>
References: 
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krystian,

On 2026-10-22, Krystian Kaniewski wrote:
> - Do not carry Mehmet's Tested-by tag because the registration ordering
>   changed after his test.

Retested v2 on a Colibri VF50 (7.2-rc1, ACM next to NCM) with a 3 s
delay in gs_close(): freeing the line during a close, opens of the
retired line, re-creating it and 4 add/remove cycles with the port held
open behave as with v1, every port is destroyed once and there are no
new kernel warnings. 3000 opens racing 30 creations of the function all
succeeded.

Tested-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Thanks,
Mehmet
