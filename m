Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0D3C4B89
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 05:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895208; cv=pass; b=dZaSz9lcFr7TGjCP6duYL5S1F5nS6abDwb4Zhrnti0di/VkoxSvIJfEnncqSrn1nCLp0kC3FFyS6LKAZxUdsTLX5baRA6fAovynAZ+qWXNfd1/csAogYWmAijm1eWh775ScQbkG/3eBHHzXoD9ESVikU60Kfk5OnljYcJRhwQaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895208; c=relaxed/simple;
	bh=fCXpJWGL0HsRKyVrjB0SFpLwZh2xB5IoQduFHSkNNms=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=mn4ZbGiXv8OdJ+gz1GGx32mCBKcfj0+Ft/R1xp69+tEQDl70Odgj4IRJhqMQ+ZHMBQOPVEdmR0+mavmPl37wFF2vipib498Q90HtahD5/gb0RxDy3RBL1M31EjKMxsmXxzFLoa318h5mVx0PnYjNjmG0LHOFUhYmmOTgqbihUZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=tN1DWNyU; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="tN1DWNyU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so1195312a91.1
        for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 22:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895206; cv=none;
        d=google.com; s=arc-20260327;
        b=YSIxzALDiAOq/iJxldzeseohid1tGQHGZ/cyQnIeVEmIbHyP9sV2BMAZQO5nZdld10
         ly2rMmpZ82cadAjK1gsNw999bKo7BF+F59Hjho6F2e66uxNPVbdDDW0qyIZANW/o3G1d
         I2h1eK5e6xmBn0ISu1RXdHonUBFA41gBmOKiDjixTLC8ZYTBYuOEv9zlSkpMVNzEpFbN
         gHw3Bgi8CtxgUG/5wg5EcXBJo26B1Bi6UqxFHMtsiTll3YFmGn95z0KhUbfdUdQroyTs
         sEkeEGk9p/w/3rYrm2Ni3TLAFTs7ycWRPfI4q02a6ILEliVLONdLCtLF93AO5DexXXr4
         E0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=7O7l+IQrbI/ZxxlPuQjVLXIxWYmvm7xGFp595JbNWyM=;
        fh=rcbbUM3UgQfPuPTZRmM3bpkAKNIFAEmDh1CiVq6JcMI=;
        b=qa0+xVy3c6Ip/lIA9CPryxsEL1gPsPB7j6/HyhN0C486gSqsB01YRJHliCw2EVC+Il
         vf+X2KuM0bUNenlLlPmdgqQbEl0VXet2tb3BRTqWCY5sL5oD3tTXdjK12dJdrTfqvzSi
         JJKOy/om9rP8k6xaGf5OWcIIXivK8ofrN3xUFEkgtfsSwRXiUYoRncRyDYshH8SJXgn0
         J/C6wkh+64AyQHSIOQRxRensZJK/NQU9MOLxOvcAxGT8TIJ1tUMwWVJQkzQiNyRSYvJW
         9MqUiWc69HipwC2xCBeWMlmt2+6V5IWCrBKYLW4egv11GlLmj8w/51oX1I4rlnaL4wCx
         iqvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895206; x=1788500006; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7O7l+IQrbI/ZxxlPuQjVLXIxWYmvm7xGFp595JbNWyM=;
        b=tN1DWNyUqsuqyWbC1B8q06g90RQLrmamoy/G///XXmwXF2kXXFZpXIE5do5XjIYmZd
         W4JcbQ54JalGg3ZzUiIJfA2ELSo2pZ2jMV3+phmUuxQlp0e3OOnjMwJQii5+xSQyMNSz
         3ebdOL/2hguP8N3gcjrdgzMpC6g2QI2RrlzzK4NP+gMWefEXj7JSZIrlXr4PYDoShz5V
         5PM9r7oIf9DW4HzzOenJ4nU61jhdx2LNkYptqfQNCX1Z8SePD/tPN5/lerXtf3Fp1l3o
         JpYFWPdSjnOxLMIYNh0dK/+68H9sfyhGWJe85vpgENFmA0L9qEwbYXeM9wEKQiF7FHD0
         Bo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895206; x=1788500006;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7O7l+IQrbI/ZxxlPuQjVLXIxWYmvm7xGFp595JbNWyM=;
        b=ITs8buliIJvNaihk7dTUY6cIfwf1JN6qaijVYD6FdEerVCAHxE6klNnHCGMYNnBp5U
         Q7dMBopWAuVfuP7aNkf+6iN2oQNeHgr3+C75x5c/Wa5UZsml0d7/awdhpR28S4VWL0c6
         4GPGhazmTl3pa93pKtTjWDnvZdrfKao/+yPHwZmVGvprNNjE8oMdyf+2AepyuLJs7eSm
         2SOhSBZrP8kvGOC+J+MrS5pbo+kfjPuqFYzdi6PC1XFlx8alW4ZnJlnIKgPL+uJWV6iL
         jj7pSJEIpQ2CGR2XwymUGr6kws0O70DyQYZTpJHx24mhSn5Ps8mYaVDnu96K5xX/t4Wu
         dJ8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpMqovimbxIud1ZlEbtsQBffya3tXYf3YuTyiVTtZ0IoHT1XYQ8xZHV1fIJhdA4AUltN11PNNIoOrTy4q8=@vger.kernel.org
X-Gm-Message-State: AFuF++mmPqN44v3975GU03hznYIl2xQokXq3CmXTecgUZQYlWal89bn+
	a54m0EHQGt/aCiLzXN/dkvFlZ6uCJIs7CMUISZct2FT92MZvT2io3vCvB+H6CHIUcEPS9ipoBEc
	Sl1RaAzC6ro3iQYejaf7v9amCIY/7B8z/L6dhuz6P
X-Gm-Gg: AR+sD11YIxAS58jSQUM8WAzL1kt4NhOstFATLKt9csBy0z7RIPBn134uyYhHro0Qdxd
	IxgINN0wFAuZQE9vAstEgnc47eS9OhtVXQpMCrL3En+lBNzMh5+3rSelprolSqQmQAQNdeuXd+k
	qZChaqPyhTJLtOOw3MUlC6zx+o5yr9c5KC9NPdHoxcIHxonLwPK5hg3fzr5pDPnN8D8/fW5iKbw
	adX8B/X7J4j7V1BVXJW5l6QcrM13T5o9q9lLlaljk0xxOp6IWEWa3oJUOfD2GJFN02z8oep74bh
	GasyL/fxU7KNXlRidizzZTXv9yFF/x+tgpK3t+msOF+5Q8O978NT7ULJer6m1/vfC8hf+YPFnm9
	I3OXu6SMADPqaAqA8QkIGizpI0IRrGZ4w
X-Received: by 2002:a17:90b:2885:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-396d0d2f6cbmr9349899a91.2.1787895205357; Thu, 27 Aug 2026
 22:33:25 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:33:24 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:33:24 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:33:24 -0700
X-Gm-Features: AcwNN1UwGy6jymCAHOolL1mUNh6Gl_8QUCV28vDSjljrT3oZC7SNgIbgai8Hcvk
Message-ID: <CA+0ovCh_phuo7TsORd9dZGA3joG6rAOyXm=cv9+BrGgQb4w33Q@mail.gmail.com>
Subject: [BUG] nozomi: missing BAR-TYPE check -- writew() on an IOPORT cookie
To: Jiri Slaby <jirislaby@kernel.org>
Cc: falemi@asu.edu, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/148-tty-nozomi-writew-on-ioport-cookie/

  nozomi 0000:00:02.0: Card type is: 8192
  BUG: unable to handle page fault for address: 000000000001d044
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  Oops: Oops: 0002 [#1] SMP KASAN NOPTI
  RIP: 0010:nozomi_card_init+0x9fe/0x14c0
  Call Trace:
   nozomi_card_init+0x9fe/0x14c0
   pci_device_probe+0x436/0xc90
   really_probe+0x267/0xaf0
   __driver_probe_device+0x1e2/0x350
   driver_probe_device+0x4f/0x240
   __device_attach_driver+0x270/0x410
   bus_for_each_drv+0x258/0x2f0
   __device_attach+0x2c5/0x450
   drivers_probe_store+0x11c/0x220
   kernfs_fop_write_iter+0x3af/0x540
   ksys_write+0x150/0x270

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
