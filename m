Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180AA29824E;
	Tue,  8 Jul 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959312; cv=none; b=dLLf9C3MoD0y4h1sj9A1WUyQxqT6lzqQeqi/yPYl3BHrzoyO7YPosQc6j/GfdndXX4VBtLQGuWv31k+fqOhrBcFoK50GFBHxfuH8GNWiCBncn3p1y8VSxFPyy4jEuUqDG4rbjqD5FpYHrmCIP5k+loIc2NnQVE1AY0eKPHinRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959312; c=relaxed/simple;
	bh=fqGNOP8FBJPLy1RK0X+MHfKS0hKOfDFe7Hn4OMwdWtE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jSvSi+UMY6FsmpMKo1app81tXjUj9asIOpl74FGBJxFL9+pz35uLQVKsMeoRKYH6z/Usu6UvDyt4iYmuYlgk0SXJmaVPMYUUOQhYZO5Ex4UvhIcjS8+SFRKoIiOc/O69WloBzB031WW1omJSjOBZn7P/BWTRmqJe3GSiGy5KtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIlF+J5g; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIlF+J5g"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b165c80cso3962798e87.2;
        Tue, 08 Jul 2025 00:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751959309; x=1752564109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fqGNOP8FBJPLy1RK0X+MHfKS0hKOfDFe7Hn4OMwdWtE=;
        b=GIlF+J5gxXDvie7ZI4folaN4tQS5Fl704k5bwyXi57J2UoK3glaJJmX4kPjaQSXGt4
         zprWXj3F1nCFIkMUcF18c3hiDJ1qiRvdEM2SpFKpt4FZmNDkL24fU2rxFzO5ezuwy4fb
         pESLfikPNIfCCUwPTaW7gPNHSTRg/TkCrNM+MV4mTGsP9z3TRrudoh6/FIl+VLrZoZQU
         Hw/DCiLfahQuqntGSWcgLbMO1lC6ONgXwCKLfMxWp93Aap3qbxdjNchEvtgJzoGsFhqW
         PQPNFhEjFvqBK2vldGoIxAzOgE51lkjYvAd6CyVPzu/zJC6fi3d+Tn6DMGlj/wXBUq/M
         V3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751959309; x=1752564109;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqGNOP8FBJPLy1RK0X+MHfKS0hKOfDFe7Hn4OMwdWtE=;
        b=BCpfosn+yMpw8MmloSqWpjP3OqrCK0EbcxYpY2jIY0rOCmLJ1RFdtV7h8yBmK+Ot33
         DqfVSjPnaiz/wAakt+uh0CXK/sGOg1rj+3/AuXajzxlu7gWKNAgh8xJS/3QH16f6lWjP
         VJp+dQNYAUn3jiZ663cljzI8sl4thpx5kUQGmDSDwIciZJ6kIkiU3kKiO+whjCA/iiEU
         mmXjHxbc5EsYbhWK2GPMo540CwOcMRRm6kAQz/RgOEWi2NPXUs81u8f/dlphaB7TV6uT
         4Jfd+ZVfuXB0PSNUew0i+PIbHslm3poQQLkhHB/Cr6QMxvMNMiAK+tCwqh9c9eCS9bE3
         A5JA==
X-Forwarded-Encrypted: i=1; AJvYcCWLO+Hidz6PlrmihDHVq5hM9bJRC0f9/v47OGsjhx4WszkAdocfESkDGIe3nCOjuQpvtjjWYn6E6ciMMrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMOvfobehx4evh58v94hGIoL+NPmXsbRUs/iQ+lPKUlkCLQrK
	NrIkMuAf7+nJb8Rj53TmchewnIoZi0P65lfkdFqqzJ056BnEjhNlR+Bhed04wfAj3CVnhH4l7Z5
	Rf8HcgAzPTZFS1U8L/m02c//ZJcRwYWc=
X-Gm-Gg: ASbGncs+FmdKLsXHAMZ/obnclRnF2D1m3dIk/GgLAUIhkQcrNUPSmc8xiaF6YN7et4M
	7FIarjvNLl0GMWVU46o/dI7i/IURKwDshg7ctgkNZZTGG/i67nWwWkZYLvNkg6UOZBmvCZj7TtO
	GWWy6HaqJ8il2YTOXEIq3gP13BD9M1N3PUD0B4BC+u4fZawOiVZj5qXtW6EgaveDP2OA==
X-Google-Smtp-Source: AGHT+IH+aAgWpAukCcmftBbkyq4OJ0H0gADAY9FjTzUG8UlxvQf98BIs2Ic+2Qwqzp7BIC2pDD49QzqGbVEcyvMRq9Q=
X-Received: by 2002:a05:6512:1314:b0:549:8f10:ec25 with SMTP id
 2adb3069b0e04-557f8353368mr619030e87.31.1751959308810; Tue, 08 Jul 2025
 00:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Tue, 8 Jul 2025 15:21:36 +0800
X-Gm-Features: Ac12FXzd4DMBrD9OuCc4Pv4dRViMZHCfjGnBhuXQCUAEp3a_lF2ko6fZ2IO8Q84
Message-ID: <CALm_T+2AUcGgb+ukfGg5a3=ibQzRe93gHAzjh6XUubCePk=Mig@mail.gmail.com>
Subject: [Bug] WARNING in vt_do_diacrit in Linux Kernel v6.14
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.14.

Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)

Bug Location: drivers/tty/vt/keyboard.c

Bug report: https://pastebin.com/yuVJpati

Complete log: https://pastebin.com/qKnipvvK

Entire kernel config: https://pastebin.com/MRWGr3nv

Root Cause Analysis:
The vt_do_diacrit() function in the virtual terminal subsystem
performs a write to a user-space pointer via __put_user_4() without
ensuring that the destination address is mapped and accessible.
Under conditions such as memory allocation failure or page table
unavailability, this leads to a fault during execution of the mov
%eax, (%rcx) instruction.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
Luka
