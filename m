Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195816132B
	for <linux-serial@vger.kernel.org>; Sun, 21 Jul 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721568963; cv=none; b=lF3lEvODAME64+rRCP7espRvl0YnHF3IdtbKBDmRl8dzYwQ/hYKk9PfrOOKCOCrLTQQsXojR1Y1v1eFehaJ/cKMakJgX/HRM3Bheoc88+o2AWLa6Au0EkYoly77JZDJOxxdCw3NNWut41BXiJbmmwEhcqBrkb52E3KXVeQIBNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721568963; c=relaxed/simple;
	bh=4U0BbAADFywgbtDIyIVL/LjKJ3rmL8ea7vGwwovYG74=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qpPb0ZxOKIW2CtujBAQZJ8WZ43ucf91SLi4ZA4iuGegpTGR43xOvsHiiU7Scsbps66NLaUInn8UtQKxOEJ6qgeRi/OQFCSAWQtzFu5p1tWKAbNThj8mzhxteAEMiF04eX2jKKeqpgyWUoDWrn4uyaYMvbxuQyr6CHwL1B16SDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39941f4c5a1so20865265ab.3
        for <linux-serial@vger.kernel.org>; Sun, 21 Jul 2024 06:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721568962; x=1722173762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nz1UnFLAroi3pASI6lDspsZ447bwQwghhsCOEF90SzY=;
        b=d/ycXqdRwRfQ6St6MXK4k9Qi/oWke5t4WCqkL/DDLrENLn+buv74Agzg9t0u3RZWHq
         vNQyDMdyCXHv/eZ9zcNlZbxvzSAXXbPYHZ0M5cuN5fSWdIAjck5IyPqoYYWqO9lBYqt6
         QHboiYp7fSKrSEJYtDSgrvWYuEYh64Yc8Cdamh8X215/KlinjwFidrpr+rdJtkTskWaT
         E7ENqcnWshYt4TA3dRnFPZR81P3v4GQoIo6l9kjxZ2BhreikNvVgrRfWj2wAZSof3p+g
         4Dq4rT3y5vGXHEx+eksMhQlLAs4pxCgvyH1T9rdLhKRERF4kEFJU7aD/P77VQ3oJQ/rH
         XWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpYo4j0yjUYkBfz8s7JqFRCAsafnGAEgzDn9447T1L1T4ZFwPwpPSMACFk5QVx08v5/QSwfqvyzxOxakRZ0zizgJn+mtkuA7WS5IUL
X-Gm-Message-State: AOJu0YyNcjDzBFpQdu7bxTZAxwpriXXyi64ZDSuGlFw+IguXLgak7lW6
	VaK4Hyxf9i5fyKxT/4DxsyICX7crfuJiA9fyR2OuJOPkjl9kzMk28CEQAERT8hlzZjtbEMWZoXg
	QsyNtshMj3iV0MeMqeCde+prPf1+tnW1qptF9tTTo1k9Cnuw38sf6qpI=
X-Google-Smtp-Source: AGHT+IEPG2xFPa10wFFssYabV8AvacYNIR5eSjxQjBBTIk68tCS6oDKI5bQyWj0iRsonWiE63orhnCn6N1iOOL88IUCRu7hglyl4
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:381:a6b6:2dbd with SMTP id
 e9e14a558f8ab-398e725d3f0mr4496465ab.4.1721568961906; Sun, 21 Jul 2024
 06:36:01 -0700 (PDT)
Date: Sun, 21 Jul 2024 06:36:01 -0700
In-Reply-To: <000000000000dd5b9f061ab3d7a4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e5e08061dc2027e@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in uevent_show
From: syzbot <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
To: andriy.shevchenko@linux.intel.com, f.fainelli@gmail.com, 
	fancer.lancer@gmail.com, gregkh@linuxfoundation.org, 
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, marcello.bauer@9elements.com, rafael@kernel.org, 
	stern@rowland.harvard.edu, sylv@sylv.io, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a7f3813e589fd8e2834720829a47b5eb914a9afe
Author: Marcello Sylvester Bauer <sylv@sylv.io>
Date:   Thu Apr 11 14:51:28 2024 +0000

    usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d54f2d980000
start commit:   d35b2284e966 Add linux-next specific files for 20240607
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d54f2d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d54f2d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
dashboard link: https://syzkaller.appspot.com/bug?extid=edd9fe0d3a65b14588d5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10905c26980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1122da8c980000

Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
