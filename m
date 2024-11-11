Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450E224FD
	for <linux-serial@vger.kernel.org>; Mon, 11 Nov 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731366479; cv=none; b=foO0+lzO3rzXc5JhFabmSeLNN36F9aMqHDqRT4L6myGUpen7X5308i+xaAGOCPidxgagNKiUoDq3q+yQzd/lNulAsMQ+Q32t/QYY8Q0Jh66hw5LSF0BcNIEP2bvEHtWQEKawbdHJDIEXvKBxya+/iJbxWLnDAX5uq7Lg9aBPN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731366479; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=tR0BYrMoDhxiH9YoamHoul4+yOnrFHOF0qDQDlbS8O31UehWgNOc2xluJEx2RxDQ0sXcEVsI4uR1c5oAhdd2NBIOMhj2sQF0+h7QnvDO27RTYhpzDrPb3vbQfC0pYP6gNeOlakkeAgSf666q2cZNHmYR/5I3Ro10HrqqtiiVIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwQ2/Gxo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwQ2/Gxo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314b316495so41368095e9.2
        for <linux-serial@vger.kernel.org>; Mon, 11 Nov 2024 15:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731366476; x=1731971276; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=CwQ2/GxoTiOeQgg5UK84I/fjgc5XVYW3OEtCDBBks3HFT2TNtTGwSN3NXSgUf3QlZe
         O8tDs/gpldlb3mSuJroklB2YKi16tnGztyuiDsVK912ru3pIv0XA3cRsD9yRKPG8SBAb
         yknxENsWc+dT3ojWy8mGl3QiUnfPyyRo1ek+W9A41d5zhOVMi9O/uxYzOX0L7QTRAar1
         7pMvln8yy2plYPIxhqkZn2cmM0+FMcZ8CBFag9ErWvUQsTAxx9mPhtGM8gsWEC3pKjX2
         asxxycPUvyV8fhmD8po0KH4YlvbjSPE8UBTioAIRQvNJ/3KnpLWa+J6cEdwRsUqQ1DGM
         HBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731366476; x=1731971276;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=E/01osVKZUKnIgXlKjFLwy/oiRMXr7UjSKLGsiw4PX0fOIjgzkpEqJX989TVdg/sYW
         YpCx+XE8g6EJQCgCZae2gznO0Jfc2zHbpGgDr5WdRPZGyw4f99BYGLKLANXWoSToZ6EG
         4CUUaNtW6h9oTtYgPsD88R4SNICrB1MbGVlYNtVzc6itvKOYqByOGrhdxHp9+s+VpYDX
         KnKQTCSWTJwI76iRWqCm+TS7OmwPlzweoRG3yzKUTShPcIM4vR3vpVQsTkoO2tU7h8EL
         4rHG5eDPpwuRypkpQ6NmdQ/dADlsLWeBecMzF/Xau2D3ZGqOWY7fh0oiCW4p37fG2uGH
         t0EQ==
X-Gm-Message-State: AOJu0YwFt8KAmS6Xd3hxx1i0pW+dQ2dZK/ebvuOUIZ+HZBR5wd1faKUY
	jvcc8cynA5HajaAWbInwtypRqaS+5gsJEmD+8YeXGnB3+kQy8VTMzyL7fQ==
X-Google-Smtp-Source: AGHT+IHw/u1Y9raA1IAOu/pxioFflpGLBMX5WGoCCB/CT+iBLchPviG8GhZUCw4AplI23/VmNEw32Q==
X-Received: by 2002:a05:600c:a04:b0:431:40ca:ce5d with SMTP id 5b1f17b1804b1-432b75172d6mr112745405e9.23.1731366475989;
        Mon, 11 Nov 2024 15:07:55 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm187348985e9.17.2024.11.11.15.07.55
        for <linux-serial@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2024 15:07:55 -0800 (PST)
From: William Cheung <royfootef@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <ec50611572f6888b2e8083cb4e4454ece7741eb00675dfd81842aa58324277c7@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-serial@vger.kernel.org
Subject: Lucrative Proposal
Date: Mon, 11 Nov 2024 15:07:28 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.
