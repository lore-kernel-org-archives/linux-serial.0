Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C111154C04
	for <linux-serial@vger.kernel.org>; Fri, 29 Nov 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912111; cv=none; b=jRP8wSBkbrOMngYSX1qExUe2DIL9Tud5V86lShbLhFX8nUdbgiOgFCkuT8YD7KMBUn0Jeovnk7SJEFEYW1zTQPullMDwwsD53N32NnG5yBl7piHc2qWdY1N7XGEil00RgF5l/ukohaBLXUjZvZNxf/mS2o9E8hh5GMfinjgZbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912111; c=relaxed/simple;
	bh=gwUK9l6qgO892ybXoJEt3H9VFyiJ8/SwoppMeYF9Y68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN7jYxcPmepYC1TQxW3hBHzsBafnQBwd3RAWf/tcGwYwDnamyqWJwPHSXemA7nGXXEA5YJe9bK7+3q2Zf9ldqrVcUVRuxSiNTJIBrA7RPNQgbJQHtoVkSu2cbL4FGbV+HAw512mQ7qaCAphG56SiqYfQp85yOObr0YASe8yB4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FovhhKb1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FovhhKb1"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0bfa52bd9so563402a12.2
        for <linux-serial@vger.kernel.org>; Fri, 29 Nov 2024 12:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732912107; x=1733516907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4wXiyYa/UqigkuopokYOURbzNGQMtk7G4o13Nu/4ERk=;
        b=FovhhKb10SR/e3pvly/jRfqKZRMJcyIik4X72JQ35CF4e88PQ2ZhbujkgBZFyy156I
         Brxp5MGL873JWXjkhU7zNOE4B0lLRu10VRj9ptaiFdbrxp3PHHo1lU/B4TxiBrCkaO0T
         PF3lsWngtCH+WpOQScWrf9YBfm59h22VP79Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732912107; x=1733516907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wXiyYa/UqigkuopokYOURbzNGQMtk7G4o13Nu/4ERk=;
        b=jcCvdsVYBmRxe4jdHu3RjhiYlYacRfGv7GAIwD39JGiJ8hUewQx+JOtvYcPnHBpvak
         a9I2tFfdTUlaq5Pkj56LzDziNpvRbh3beTd18Cfk27awFxuk+5K0aGaWELn3dM2mvawX
         OTx3685ILPMBaK7I/sUMHKa2bJOLqMGyvvIDoS3J5rVme000ua+A+j5q1d0kfw/zTdzy
         xZ22EYIt0PlX040FTV4oBOYv8wGCc7JlkfbdaOj5XvfL0TPkt85vIN5VntrtlxwpFgeP
         iT7hhP6FpvkDa6nHsKBHtXRtzxzD2ZdeZmU8VEF/ymOzLxMPcg1yb5YitzZGU/H7DwHw
         3sTw==
X-Forwarded-Encrypted: i=1; AJvYcCWjSD+SXRFs5pPbrD/rWL5jZsQEDVpI1DuwYB1Gb77mn6D15Ced90fYm1TciWriJd88p+fWEA2YmPP6wnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycq5YQfzuTpF7WrmjwQa6VZPvDeeS/lKh3awxN96zXyrwDr3YB
	nIuKvMSmA3u3gqRryj6rBMMDo5cJVioHjszenzQrKodKGQAy9hurGwqiti54jTVe/S4oR8sxSW9
	CWrQ42w==
X-Gm-Gg: ASbGncupuCpcoMxryTwOthpYmo3C9fhRoyAGjWU/HovfQro0MCmxqi0YciIgdpjV6Kd
	pHk5np8K404kzi7j98dwfdLI1WQAjPNIm2QGEnhOvnvSx8xpAmCSk6w4nF/IKJDrGcQq7Xv/R9H
	+BrYMbMxuavNvRi7t35IgqFUAxIGjbYjpOgxzQRP4f/5Jr9UZlw67ObCCYUyVEGVIZTSxsWLdgR
	3FXuwoPfpBprxPLDQk3RdVKlX/ejgwat/cCjgGrs151LRdGkFPeeeS250AiQWsp7FqeuUUVC8wV
	kMsF0F9T2co+lHmkruvo+F4r
X-Google-Smtp-Source: AGHT+IGf+3l/rM5z90bZ1214dJA5mybXYogMlfIOvkkiOE6wKor6RRC7jGupRsufXgvTy2L3i9LGNA==
X-Received: by 2002:a05:6402:4015:b0:5d0:9081:7929 with SMTP id 4fb4d7f45d1cf-5d09081793dmr10778977a12.23.1732912107058;
        Fri, 29 Nov 2024 12:28:27 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd5d9csm2145168a12.37.2024.11.29.12.28.23
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 12:28:24 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0bfa52bd9so563348a12.2
        for <linux-serial@vger.kernel.org>; Fri, 29 Nov 2024 12:28:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVe+BdeVBVmsM/HvwWHF6q2H5hfyLtkoouDmXMON/pEo7FUDm7r+yOyQZFbVlkjvksQfy/5sIU+piHIFUM=@vger.kernel.org
X-Received: by 2002:a17:906:311b:b0:aa5:b1b9:5d6a with SMTP id
 a640c23a62f3a-aa5b1b96013mr334340866b.54.1732912103149; Fri, 29 Nov 2024
 12:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0lCihhE75lE9Zjd@kroah.com>
In-Reply-To: <Z0lCihhE75lE9Zjd@kroah.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 12:28:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXUMgkaJyQiQbUBNR-fVQC8LO-QPJ7y-30oThQCBDLag@mail.gmail.com>
Message-ID: <CAHk-=wiXUMgkaJyQiQbUBNR-fVQC8LO-QPJ7y-30oThQCBDLag@mail.gmail.com>
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 20:26, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> TTY / Serial driver updates for 6.13-rc1

Greg - I've dropped this pull request since it sounds like it will
need a bit of fixup.

But holler if you prefer I take it as-is and I guess we can fix it up later.

            Linus
