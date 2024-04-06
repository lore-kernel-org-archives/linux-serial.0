Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0503F38396
	for <linux-serial@vger.kernel.org>; Sat,  6 Apr 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712415185; cv=none; b=QB3YN5FEs0/wfdBmraZTC77iYYf58mOh7ZOki50VErZT2F1/jKB1i9F3lRajWB9oEFXE1rxF7fKd4RYFiuTr+Akz+C5j4RO17edPtG9lvzuNRI2NiG9k62RY617H1BzB5kkC2Yr3XmAG3b6UPwdftnZDBm05kWPkdDdSTnaulIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712415185; c=relaxed/simple;
	bh=auYPgHpH1fvE3vDTd22n48x/is2PnNEzGgQkEgkMTXc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BeojV5R5R4rX/4WpL8E3Fkues96srFgjkEGZuofXidfd1uC0i0QVTSs0eEsTzX0LaX6Z3Qy/Vvdk2Bmxb/3U+FtEqwbDXJ1TX9rKGlrV0FluB1AHh3H58CgnYBMnFFb9fb4FbL1ozPDyK+AK4dL2OhaFwO8GmpbefbcwEm4mDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc61b1d690so251185739f.3
        for <linux-serial@vger.kernel.org>; Sat, 06 Apr 2024 07:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712415183; x=1713019983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEusqzjyCIPwi8EF8zc7zmzz3Fnpc6T0myuG8LrsPzM=;
        b=JboN4jWHSF0ZPPpFXwKGlwYjyqz4w8D0I/Svi8UlxBq8ZSRvliUrT8R7fQXBsk51Eu
         t6Th63HtWW64POlu+ZzIe8QohJ6xwVZQk5EJ/pePDhjLnZByKxXzhJsTUbrc+kHd/IkI
         +5TGADrzG7y+KOCwnYawZTOI2bA0ZSbWC17Fqh8wjVPlmEeSjlmTYvuZkIC3luuKCwkt
         ZN5PnxWhJPME9uvXupsqqFwmnpVvtY7fN1wRSG7m8qxdt0TNWzGJ0ozkJ3EHkKF5XeGs
         ud/nY53vV/QGaGvW9NF9eqfXthTGU2eaEA5dqS0QS61HjNmDSq5tc2SIVcwBnj8RVq+B
         3C+A==
X-Forwarded-Encrypted: i=1; AJvYcCVhZYFByN44ANthJwwIFRWvTkR+uaa2mGj0Vh2y8GBNaEhfyIwzeFavuYJUiFDkHzdjE8G5hsgx/XxN0IwhHagvjChN1LpXAjpkYYSX
X-Gm-Message-State: AOJu0YxbgKcNuOJNpUfZF/IcyYvefwmghyVZpfmQOtH1OwfrEIKDhUj3
	s5aUHHBbDwBeWxGyUoNMBOTOFfQoizT8Mp+88lgWMK4u7TOjFTufyD8hFTP+LkX3elfqPR2NH2r
	ydXdlhrzLWeosTgWpmLfilE6yoTeHsjNn3SrEiJtA4tbLxKgeao8vq64=
X-Google-Smtp-Source: AGHT+IGqWeZF7f7qxBteGm6LpkGvg/h+4M+Y5AMI0eMsyZbEkG3/n5Zic67Lt08n+DG5lWhDcKmH9He2yIUjrlrdfLA3GvZEURjq
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:368:9bf7:6b6d with SMTP id
 g14-20020a92cdae000000b003689bf76b6dmr260400ild.2.1712415183224; Sat, 06 Apr
 2024 07:53:03 -0700 (PDT)
Date: Sat, 06 Apr 2024 07:53:03 -0700
In-Reply-To: <ZhB6Qt48rkC3zMUb@surfacebook.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4522906156eba46@google.com>
Subject: Re: [syzbot] [serial?] general protection fault in serial8250_tx_chars
From: syzbot <syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com>
To: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@bitbucket.org:andy-shev/linux.git/test-8250-pm: failed to run ["git" "fetch" "--force" "f7e55974102a831d64e9ca077790e9122f71f6c9" "test-8250-pm"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@bitbucket.org:andy-shev/linux.git test-8250-pm
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3761490b734dc96
dashboard link: https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
compiler:       

Note: no patches were applied.
