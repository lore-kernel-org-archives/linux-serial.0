Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD923EA8D
	for <linux-serial@vger.kernel.org>; Tue,  4 Nov 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268083; cv=none; b=AUVRDzGQa+l07dWtmenJqhoUzmBU0cWWeBeFRiNQQp6sBiIcaxP/VUmGUxDABkWCLwFNreLm/Wf1gq8KoGpSPGUeQ7PZTNqe+tEt4pNc16dGQOwhGxlCEmn9+IJ26eL9Dnc/p+3CnbgBFlKCd9FlXZb3UcIuLYnf2L1ceekOjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268083; c=relaxed/simple;
	bh=SoHtZGOkpwN5ZSgnbeU8DhJb1ETpZRQWa1wSF/osbfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6Nfo4AdENG0I1jE/Xnm6SDLLOsEX+3GrGx7vRAB+pRf2DdMWtlltE4FFxxCCRx7pnX7aJWmi4cNRdP4wamVfGutQ4Jc6mYqDPjaaEsWsqIViMCvag2mj5Jeopum/NhGYxysik01yZ+0Tdalc6kKnDNi09as8RLUYX9fi8CzAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be0pWcoA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be0pWcoA"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso5571847a12.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Nov 2025 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268080; x=1762872880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtBjBlbxbG5P+AxPedmUChhqbCDi46Di3hP9tiOhxEw=;
        b=Be0pWcoAWwCPLT3bfOkZ3fujqHjLLaGVZEpyv3Ea+3Wp3rvYQ953vD5PVYAhN5grn4
         I6HIFBdNqlkJwcOtED1LujNtbX64OtI539E336xiLBRa1pqZVtq4CEMPPcAMXjIbxNat
         6ZN6YDAoaixMpih2Ku+6apXRJ1uHrCVshTAD2H6JzuZ1yWIDBsCRdVDQd/Ac/NgG6duv
         1E1bER2Wgml1JXzfidylFjWsPuObrY0PIAf8eAFrxuntu3+fBdHtY17E2puaEFRkBUpJ
         KTK7sSuaE1yPuMN2xoIfk3Qa8RXri544zKKPoI7b04sKljqvApgwyARrPrl1dYFZISnK
         QC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268080; x=1762872880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtBjBlbxbG5P+AxPedmUChhqbCDi46Di3hP9tiOhxEw=;
        b=HqrqF1hLcoa4fHIxaxZpTiP6dAo2jRfvl1HT1YjOTGhB7GHoPZ00pEV37GgejwOPdX
         IadEKI7BLLydb4ZiCILgyTYW0A9iPB9gESh+ZldzV3p9jroUI0vy/JgJqKv/E0DerKPA
         9GxLJDMNnQQ7K4nU7F9nH9+SwuEcX+rb0nT9/vr6xixanUEC5Lpd1hz8NKrqlsE1fJnT
         OpTk1OsxrQjpIPiO4WJ4Fi2cAh5wtYBgarM85nDgcFxapQPFgU0i3Ch3jKPzY4+XesMB
         F3mHcday3UA+0bxSkfWaduadSs/VEVWV4rSeWetbhxSbDH9kdwu89l+U8YIFTox4JypM
         dV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv8nJnCoa6dTnO+qiY5Yv6Ia5/sgEO/aTjB0H0y69Ka+2P1n8n87JBmOgXG/jxWJVOFmHUTRB29cMP8aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbvw7aF863kR0epKBopvfHluSfb4aJ+P/f+KEgvSUY0Wl40K+q
	3x7F/n6gWB0m9vCq52AwyYHDliyxFm5hUdsRtJbbAEFrAfFISIg6CsHh
X-Gm-Gg: ASbGncuzOoffUOjw+bpruYsoudSYSS9nQPBXy5mAk5qniz/a7BrGqV1T+Dm8Ts75jMx
	BvC64z53FFL2pwuEBIskuqdlXDNmQWqbbIAutcw3et141r52Jg3qTIQRp9suKbEimeHlF61Ihjz
	w6rd7w3woZjDnr099ic32qgalONn8KU1PMwU4yo8CucuV5Q2tvi5GE5XXsKz7zRBt016M2B1W/q
	GF3MFN1j6cupLuNKMUwHfOYRBuGJVTxUgIuBE1P2dN60xcTxWJD9/uPDbgAMgm6mGE/nKXJhpOs
	JtXJwZ8Y0eSe3Zy8Y41RBI6ml0+cH+rXod6VBsSMYNDUvZXLlSD5G+SjVHqhKlGXjIJdQpgcFym
	vvf2htzpF8U7nnjw8Tm0R+yvQQDmczYB3MH/9UxNaHOIivQIZbq5zQ2Dm2NrYz/7ZqISXGJjoHi
	1o
X-Google-Smtp-Source: AGHT+IEimrOHYKCn1i8ge4asMD7MxgDWkgnwVngHkgx5pY5obj+4FYjBvrDj4wPa0I6px9iIE31nQQ==
X-Received: by 2002:a05:6402:13c8:b0:640:93b2:fd0a with SMTP id 4fb4d7f45d1cf-64093b2fee5mr12182414a12.20.1762268079444;
        Tue, 04 Nov 2025 06:54:39 -0800 (PST)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a70b50sm2235016a12.25.2025.11.04.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:54:39 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 1/2] serial: 8250_dw: handle clock enable errors in runtime_resume
Date: Tue,  4 Nov 2025 17:54:25 +0300
Message-ID: <20251104145433.2316165-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
References: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error checking for clk_prepare_enable() calls in
dw8250_runtime_resume(). Currently if either clock fails to enable,
the function returns success while leaving clocks in inconsistent state.

This change implements comprehensive error handling by checking the return
values of both clk_prepare_enable() calls. If the second clock enable
operation fails after the first clock has already been successfully
enabled, the code now properly cleans up by disabling and unpreparing
the first clock before returning. The error code is then propagated to
the caller, ensuring that clock enable failures are properly reported
rather than being silently ignored.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 710ae4d40aec..0ff500965c10 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -741,11 +741,18 @@ static int dw8250_runtime_suspend(struct device *dev)
 
 static int dw8250_runtime_resume(struct device *dev)
 {
+	int ret;
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	clk_prepare_enable(data->pclk);
+	ret = clk_prepare_enable(data->pclk);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(data->clk);
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		clk_disable_unprepare(data->pclk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0

