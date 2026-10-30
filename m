Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347107;
	b=NKlE/fumYURRyvTgjbRVDoRBcEsB1Dqr3Hm4upc1E11z8UThuXrnjOJCMjT5xqnrSroW
	 piG+igeb4Nnx2ULtcB1lnMUhmftWCqSjbpEW6LxFoC6NvH08rN3IknCeg/VDkwUyx6cjW
	 qEZd3f7ECDTWnZdqsrcYoxkJuJKy/E4KK7AGAP4HbnhEyVuo1+pz2faxBIEdhE2hsPAPs
	 vFhN+NXzBrL7fs1Uoap3NmQlLMC5Ff5FhDazK9ZaUodYKsyJtikufu8RkunzeM7EVfwXZ
	 GBKtfZ4AGK5kuetleFoIkKBMIXDo17VeH4BZv0XtNS/0OqrYSVPsHU1HzmIrIukqSTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4oAI5pxrIzXlsyWd5vlHzyNWwBTG6cTZg/AYjzhaORc=;
	b=K3hazkPichtoEWXcgaGn75HC1xuDY7ee6EdL/m5SMCv9NigrUdzjUA9H9qNQ4cY0hPWf
	 G4NYq6w3AMwyJ3s4M9d5jtlsD/0w1f0WZxha7JNofYOJDEsmfwqIVhuanqeA9FjrlzS8s
	 b64RPWqSvA6NJ9qE5uY+9GpSoa//xkS3MsGMy/u5EB3OnrmQOeONKTkOIZqAeEwnDHSAy
	 W2PWiMfzimnrBTN2zyuzgmoRnP3AmH4TV/9tfkBbT0Urop5BORsccWzNXttKysi8FlWig
	 T6kENxTdV1jvkW6ghKj6zNkIR9sVFZ609ES1MvwkWziaipw9+QgRlm8KJvkDKVBWJAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGG9vEBq;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C4606A31D
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 07:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C1C4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGG9vEBq
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1089789eec.0
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793347106; x=1793951906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4oAI5pxrIzXlsyWd5vlHzyNWwBTG6cTZg/AYjzhaORc=;
        b=GGG9vEBqs0KOdgWpmiKWSIt5WiVXa1uTTSIYJDfkXZTot6gliH6IsN1uuFr/2jrYSe
         U7gllHE3EA+ogniCMpvqYCrZN9iykitU4bK2wKXp4ARtTJbW4ms7vkhdADyORj/ycI4H
         G3KACOujmEYbJHeu0gTiGhwGYcg2b9X5IqEJNEM4MxjkgfcZchN3kL1bz+lINiJNWIzF
         zGgqY6RUWYac/JAXO9F5JJ5jYRt0FVaae8UP7FlSjNNhD9m+UFZLz733RHavNFzFPDPQ
         dueoDefL4Rlbv0MJcoOBr6BADn6WW6jesglLMWLzYPkxnwbyC7onuwK313uY5FSCt3SH
         SFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793347106; x=1793951906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4oAI5pxrIzXlsyWd5vlHzyNWwBTG6cTZg/AYjzhaORc=;
        b=QRIPMASDp9Cqg+dRY9BXCw5TYN1AVF7yUw0lMHSMadfzhJ9vRPVMnZxyggbjAXiml9
         drW+CM1DowZm3v6VVOrA8ChMY2nMhAU4iM/9U2dDWXodO10eDQ63cJ/t4TDwagNaxHP6
         rz42ThAE9XqqzU+yhJULsqF3uZHkCJ/q6wflfehW52b5h02qUc2Y07STQJNYHgZdyxaP
         GR9DvwzjRZ/dfJuhxXT9FW3jUpgA5ntyenwvu8i+tXs1nJenJm1pznvsAhpARqvcGc02
         7wJwjfiXGzIaooQ8B4qC4P/heLMSmRNoP3kTQR7lwjB4irwl7fdPs5BNXYD3YUemsf3M
         WiBA==
X-Forwarded-Encrypted: i=1; AKwUvBxYFmMH6TKRfQbw9RjHVBz0svFyyVxj1bBFkGl4w1PyYKLb4yb/IinrljkIIf0m+4zfX2q4SI0w4jQjQTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuVfMuk4VGR0eqswKDIP9BLGQ7W3UlSPHbQ2IAjyHOZgqkE2Gg
	lBwzIVRbYw/+NDEbxP12aV6ILIY2vu//CJep/xI7Fg5AMfj4IxYcrxyK
X-Gm-Gg: AYBFou2P49m3ea1PoWvkpo67VHtpYrKcNrWFCJdAC00KLQKHp3K7w4hwQcRmMB07/Pb
	iaLIy+AXyOebKXgTcz2kgfMRDJQgjRIHlvq3IUQVtItpX6a04SOTRd1SNVq9+An9TlT1qiARetk
	eaLEcsYBEEtgccEf2Tf9qRDe/pySXNEYmV4Ve13YQ6daYVypOkAOFIF3wv1p/JD+tkVXPFPv1UK
	1gC0l47EyoVfSWY4tLxkJvoPVxCn4g3gCTzPYwL+OwQil4TzOGPN0iYuP+ggz/tu4gPaHp6rkIb
	rceYLv8aCJy2MD4r5tmLZMvTpm+RDJ6tStm8JjUJdkPuE5aaxv2mftefKiLM3PUJLj9PiT9fuPX
	o9SndzWdMVM/hOtoVmlijKdkGQJMSJkctlbdchKdNKH83JHr3UjwfSNNwevqAZ7ntoXccWAKeyA
	REAljfGyBj+0OGm4AuCU+S52kpxiXj/am+w3AcOW6Nj98naIUnx16hK9t+8wwf8J5X8tot/V7eh
	HI64v9SN7ljArIwiPTAPrs9aCCvfYBi07euYTqvoNXkxBA7MV5Y8IIe0aTwo1CN5uFXltBxts5a
	2BlJ1LtPCdtNmB93mft9UGKRAFvPSVfoGA9JMCIebgYQaeDkFw1dW1enfRps+PdBQ4Y=
X-Received: by 2002:a05:7023:d0b:b0:1a7:216d:157c with SMTP id a92af1059eb24-1ac5de5380emr2405354c88.34.1793347106204;
        Fri, 30 Oct 2026 00:58:26 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm4741054c88.14.2026.10.30.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:58:25 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written reset_seq
Date: Fri, 30 Oct 2026 15:58:20 +0800
Message-ID: <20261030075820.207049-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026103014-sketch-headed-2fd1@gregkh>
References: <2026103014-sketch-headed-2fd1@gregkh>
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

Hi Greg,

On Fri, Oct 30, 2026 at 08:02:30AM +0100, Greg KH wrote:
> I still don't understand what the root problem is here, sorry.

Each keyboard keeps its own copy of reset_seq.  It rebuilds the copy on
the first key press after the parameter changes, and it rebuilds it
wrong in two ways.

1) It adds the new keys to the old copy instead of replacing it (2/2):

  echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq # Alt+Ctrl+Del
  (press any key)
  echo 59,60 > /sys/module/sysrq/parameters/reset_seq     # F1+F2

Now F1+F2 does nothing.  Only holding all five keys resets.  So setting
reset_seq once works, but changing it later does not.

2) It can rebuild the copy while the write is half done (1/2).  The
write stores the keys one at a time, and the keyboard may read the list
in between:

  echo 59,60 > reset_seq
    store 59
                      <- F1 pressed: keyboard reads "59" as the sequence
    store 60

On a keyboard that has not used a reset sequence before, or on any
keyboard once 2/2 is applied, that F1 press completes the one-key
sequence and reboots the machine.  The window is microseconds; I only
hit it with an added delay.

If you want this fixed, I'll send a v5 with a much smaller 1/2, plain
changelogs, and the Assisted-by: tag I should have added from the
start.  Otherwise please drop it.

Thanks,
Zhan Xusheng
