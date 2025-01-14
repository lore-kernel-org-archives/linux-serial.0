Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87773596D;
	Tue, 14 Jan 2025 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820249; cv=none; b=RVdVsUCwetIbo7GgRyMyLJppEZ7hnhN8BsijLv8pHOIusr2RmQ8OXPEkHp2OoeVPLIOvHbHjyHJjitDG06627TXcubA73sR2hZKzBiVfIRaz7qQMI2OXH9P7iMebgCoBFK6TSnAydolSCII504TRnWPped+kGbmIT1PUWh8lxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820249; c=relaxed/simple;
	bh=ypL3YR6Nj7hFe7BA8SQGlMhJEFX7dzD/evw+JMLqZ5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxA5Hc/5okDCKZGdq0L52jDduHfOhKeF1Zs/nOkxeG2m3/gG6siBdZQgHGbKXMWm7JSJizfrCqJgT2XrAn615J8WBmfrFo+GtGGD2YrrhhKDv1soGsr4sbHMc4Xl7o8ceJm0IsScdqfYbkgUA9uy+ruoctv9RAesjvB80kXoMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJAo2+tW; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJAo2+tW"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-21670dce0a7so106169935ad.1;
        Mon, 13 Jan 2025 18:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736820247; x=1737425047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxHtvBKbO0u1b3b5PRLS0QHvtIJ0sddmymxdVVEe6AE=;
        b=ZJAo2+tWMDTEEbYEN35pvGrci5LXcxvsBhyCcqaAcARYjEHz8oa3LfEWvpahEIuPlV
         HRCIeVq7lVlvMldOlqibVV7DK+Qk9no5cW8B4DglK1bwCscPZ4VRKUCHuCm9FEoXeEHd
         8FVJx3HtjojWt7qp3ZO/z7flx5dC6W6JtAigOBcY6l6H4By5Fi6jBusyULb7WiWIJPy0
         8UDs3kLiCcr1JNn2a+Zl34bPlVDw5LN2OPH7ZZtZHC7R3IZpzzm8PhQZLpJEQzdpZO0y
         mlI+1NyKWIaEJazwl8UCNvv1y1NlcL2KnatGsaFvRUB/fvLeWMbaYtCJRECMSjHQDOh0
         6aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820247; x=1737425047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxHtvBKbO0u1b3b5PRLS0QHvtIJ0sddmymxdVVEe6AE=;
        b=NtCEMi4mTUv1DFrSWowmYgzTBsGRnozwv2kHY5NsOAtjDtwQ4n7WqnA7ObQUVdrDt4
         1Z0BSZTpOnGEDx50LA/uPSBwxEnKiPKDm5kasrvwE1LaAraQ8eJGfW9gA+B4RplO0R7T
         PBeWhw5dHlmdFXnpE57ERBheaCk3rBBgTIcvTYcKoK/jVvtFb9XGabtQScC4Iqp9gr+2
         43s5AncRwSTZxKVmcpfDcswWIn1yjaac+WyYA99dxoqsDfeGz5o43Peq45mpzlf7FFPd
         DhHfAWEnWzgNTrjmKaCgEFThSC6sbNSAcchW2A8CqJ1+mCSMJJRqCVJxbS9kFFQ3xLJl
         mU5A==
X-Forwarded-Encrypted: i=1; AJvYcCU7gTtxF8Oe4afDERpz3eNGE/pXvEE5HE8lS1mKNhc66LnqwILPlEdcyRj0COLOAp/l6Jf3gow3Dkv+fLWP@vger.kernel.org, AJvYcCVDUDK9/wg6WsQnvdwMuzfH6mEbVU+d+qCS4ReAkNy0scYa3ElrpwaG20fvP+/JPq3feVszyPCpPFWw@vger.kernel.org, AJvYcCX4UmDt93JwGsvQOnMQGCUyRSG+Y8Wbb2/ppMa005wgUagDrU7GLC5cjrmOXJkP6t4htcJ0zG99Tjar1GDT@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbWPUYVAE4WbyVa0Embb5MRCxPsAaP9k6bJqKIksixkBt+1zZ
	USrw8EZmUqVXSfwm9T25xo8WVD8cipU7/0WFG9SOmMaixH8lKBSDf1hDqQpI6z6kYaEui10yDPL
	ny0eNDwJfEj+wniLyemdj0nVK5OM=
X-Gm-Gg: ASbGnctiKjl/kGDQNf8p1bcUZ/H8BEkhJ901GxXM2kqwzA4gIAO68IWHVshu+uTJFDB
	s0uuoLS5Sc83hsoSkOM8KQQwFLgStaYgAvssrWxk=
X-Google-Smtp-Source: AGHT+IFZD3TPfZu6EfSA7//VeesR9pTZrj+xVeYdp7Mk2x83AZo0gb1juo0UiMXcq4hwczn5Us/QfxCGTw2p5glAVBg=
X-Received: by 2002:a17:902:cec1:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-21a83ffbe22mr355297125ad.45.1736820246925; Mon, 13 Jan 2025
 18:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113031917.3354988-1-Wenhua.Lin@unisoc.com>
 <20250113031917.3354988-3-Wenhua.Lin@unisoc.com> <7385b093-378a-499d-ae1f-4c85001f088c@linux.alibaba.com>
In-Reply-To: <7385b093-378a-499d-ae1f-4c85001f088c@linux.alibaba.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Tue, 14 Jan 2025 10:03:55 +0800
X-Gm-Features: AbW1kvYTGp5LHcN6Jv4eb5zhJk0GyEzXpwu8fJXYJemOmCqwaSzqbg5j6kfgil0
Message-ID: <CAB9BWhc9iCOMvJ=UuvB1pqh3PSvhn0h1+jAJaSpFMcLcmYX+1g@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] serial: sprd: Add support for sc9632
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 2:08=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/1/13 11:19, Wenhua Lin wrote:
> > Due to the platform's new project uart ip upgrade,
> > the new project's timeout interrupt needs to use bit17
> > while other projects' timeout interrupt needs to use
> > bit13, using private data to adapt and be compatible
> > with all projects.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
>
> People have already given you reviewed or acked tags[1], if you did not
> change the code, please keep them in the next version.
>
> [1]
> https://lore.kernel.org/lkml/20241113110516.2166328-2-Wenhua.Lin@unisoc.c=
om/

Hi Baolin:
   OK, the issue with tags[1] will be resolved through a new submission.
   Thank you for your reminder.
Thanks
