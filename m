Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614D38F957
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686607; cv=none; b=E2Q0kxIcUcJ3ivZ/KBhwu3/UagtfWy0HGjdtzmknd/+lqwgnyp0y53AmYG8MLoK+nqB5Db+Vdi4yFTbSs5nJ5Nw+pQ0uFGYEcERevjInKxfd1nziZmdpbpmXZgrNZmUieRRXT7HI+9ENCWT34KURIh/7rQPfiLU1WPMSJTjge/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686607; c=relaxed/simple;
	bh=RgQzxQwAcXHwMmn1GP6d9lKNQRGfA7OVpgfu8fgMC8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QACcXaXdRxnDwwlck3nW3OLzQMCjnzZYVmihVDIr5WJ2cJKwPR7mHIDblAv9T1vI4KYT7EuK5nCTFNoOPWOWS0B7C2XaZcnAto3snALgxR0eTqmw5IZFcBxzb6QMLvzeBAEIKHiNTdjcqFgBTNqS67Ni1MKj2f38t9ILwJz14v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJmPdhXL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJmPdhXL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35fc258aaa4so1731491a91.2
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 05:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776686606; x=1777291406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH+UDp63n0OMToyOF7805ju9M8WJlYdnyXHfyIl0SrE=;
        b=BJmPdhXLS+BKYVAqyhTjyWt8Yp6YkpkPDmGv5i1GfdiGW1PiBZ59sDDzXJ8WZELoGx
         D5ZhB21JzcXxZk5faD2ldn7x2OspMhIGhaXOFl4zUPE6Wv2QVSDH79Y7BuKiNubpgpd8
         Zp/1F/hkKMcGVurehTgI8IR0mtGQW/2fUz4HJ7nMf8AdOrTMK7RDYrpdoMt3JFCR33qf
         +Vbyf/ZlhsqRlOgLdzzzE5tb++1h2jo6E2JsC7YWvrDF/bcP+ucL26QlWLldceOKJCr6
         WY/f+uQeZRzVKLt6emOK103Y/z2flUxmJCAwhR8nCd0JTuIXSr5+jRh04QSuZWRMGkJp
         Ms8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776686606; x=1777291406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nH+UDp63n0OMToyOF7805ju9M8WJlYdnyXHfyIl0SrE=;
        b=IlDkMduAiNU7q4gdvIhZ7Jb99pIUtnsqg0jHeGfC4+qEDnwus1WRU1N2zWi6ufYaCk
         3yu0f3ifUv7SFSaIvyJavTW8OHwL/cmp9+aIUO1vARZrw+RHNJciTOlHbaah295sqTVm
         /G2aOfhxJHsyMwpBBLRa7NrKochG2aJGO45lfNQJEaLITeFr7kO9UqNDen8iv6zQsgvs
         b3vNy3kQWtyMndotXVpN2JBhvT5c3vvpR02zlfiGN89nwwpW8bJMKk+bsXOlO9Iad7ml
         4+3RpcDu1qoQQrgw2G4dknd3sAuhBUPdVt1baQJ2m629YPUPwCJSWaiz/Hg/IoA9vQpF
         LKPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Y2EY/RnxnRSoFjCvxbkeJZQZ3xuR210Quw3nKgMqbN4KnbyhH7BMIiUsrWwBW3BOLx2vqkZJT/OAjYno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrN9fKFEF1Cc5cMB1ihkHCNcblsZXsaGA4LlfRl4c8TinX6px
	gRTwcxQ03p5sJzSpLfqtZRzKeLziZMoTb9/bw0afc6xAklrzw7CCQDRm
X-Gm-Gg: AeBDietGUOPzi7l94HUz1yrhdLLfwgp0AB+HucrC9DSHGM+3pK8M57PGrrvwQjphAW5
	25cps2yH7Tk7bHsqNR/3LjFZnXSDW5zscG9Mxupcki4EL3wKibuxwd6xPAw1d7sLxGvRB3mz+Qm
	PST3Nnhlj6O8FCvkypzulU6e362ZhWSjp2/uKQniC4SjcWFkzHJXNo51V12D0W/qDjKi9ONckVU
	uUuAd7WvVpTg8P7mNRsgIH1MhDOU4XJqVHsI9QR+YZjjDKOe6Pz1CbhyKiBDtpG4nqKZd8W+Ebm
	0hXJUGoKnMcVsv/dI5ln9HWglflB9O4aK6GOkr1IzW5BCZJ44puvEB74yIaQ4Es6Wu0vw+dnNef
	Ha5yKUCYlMYf3oOsQKriBsvNCZlO6I8y6hbhrU0fkv2pValQoO+lvZczUY1bBi1xBwPN6qGQQTl
	M8CJwqK4CmxerFUipC0FoZo0xiQW0eKWRFxKIi3mNi7qA=
X-Received: by 2002:a05:6a20:a12b:b0:3a2:d79c:414f with SMTP id adf61e73a8af0-3a2d79c440fmr2081566637.48.1776686605729;
        Mon, 20 Apr 2026 05:03:25 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9da4esm7701481a12.11.2026.04.20.05.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:03:25 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	gaoxiang17@xiaomi.com,
	Xiang Gao <gxxa03070307@gmail.com>
Subject: Re: [PATCH] sysrq: add optional logging of caller info on /proc/sysrq-trigger write
Date: Mon, 20 Apr 2026 20:03:20 +0800
Message-Id: <20260420120320.2137235-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026041830-visibly-underpaid-6dc8@gregkh>
References: <20260416131419.1231012-1-gxxa03070307@gmail.com> <2026041830-visibly-underpaid-6dc8@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Apr 18, 2026 at 09:20:14AM +0200, Greg Kroah-Hartman wrote:
> We really do not want or like #ifdef in .c files, and for stuff like
> this, it is not needed at all.
[...]
> Module parameters are really not the way for stuff like this.  And why
> would such a "tiny" option need a config option at all?  If you don't
> use/need it, it's only a single bool being used?
[...]
> n is always the default, no need to add it again.

Agreed on all of these. The #ifdef, the module_param, the Kconfig
entry and the 'default n' all go away -- the feature will be
unconditional.

Before respinning I would like to align on the approach, because
your comments on the kernel log and the ancestry walk touch the
core of what this patch should actually be. Let me describe the
real use case first, since I do not think I made it clear in v1.

Use case

  - Userspace triggers are typically several processes deep:
    some service -> library -> system("echo c > /proc/sysrq-trigger")
    -> sh. The immediate writer is "sh", the actually responsible
    component is several levels up.
  - The sysrq character we care about is almost always 'c', 'b' or
    'o' -- the machine panics, reboots, or powers off as a direct
    result of the write.
  - *After* the device has come back up, we need to identify which
    userspace component issued the write. Otherwise there is no way
    to debug why devices in the field are rebooting themselves.

> The kernel log is not there for doing audits and the like, so is this
> just a debug option?

I agree that security audit belongs in the audit subsystem, not in
printk. What this patch is trying to do is post-mortem diagnostic
for crash/reboot triage, and audit_log() cannot deliver on that:

  1. audit_log() is asynchronous -- the record is queued, then
     delivered via kauditd -> netlink to a userspace subscriber.
     For sysrq c/b/o the panic/reboot happens before kauditd gets
     to run, so the record is never delivered.

  2. In our deployment environment there is no userspace auditd
     persisting records to disk, and audit records are not
     preserved across reboot. The kernel ring buffer, via pstore /
     ramoops, is the only channel whose contents survive the
     reboot and are readable on the next boot. pr_info() is the
     only mechanism that delivers into that persistent path.

I would frame this not as audit but as post-mortem diagnostic,
retitle the commit accordingly ("sysrq: log triggering task info
for post-mortem diagnostics") and drop the audit framing from the
changelog entirely.

> This might cause problems for when the system is hung and sysrq is the
> only way to reboot the box.  Have you tried it in that situation?

Fair -- the while-loop walking 5 levels has to go. The reason it
was there in v1 is the "sh from system()/popen()" case above: the
writer's comm is "sh", and the information we actually want is one
or more levels up the parent chain.

On the hung-system concern specifically: /proc/sysrq-trigger only
runs when userspace is alive enough to complete a write(), so the
keyboard sysrq path via handle_sysrq() is not affected by this
change -- my patch only touches write_sysrq_trigger(). Within that
function, rcu_read_lock() / rcu_dereference() take no locks,
allocate nothing, and are bounded-constant work, so on paper they
should not introduce a new hang. I have not yet reproduced a
partially-hung system to verify this empirically; I will do so
before v2 and report back. Please correct me if I am misreading
the concern.

That said, two options I can see, would like your steer before I
respin:

  (a) One bounded rcu_dereference() of current->real_parent.
      Logs current's pid/comm plus ppid + parent comm. One
      level, no loop. Covers the direct case
        app -> system("echo c > /proc/sysrq-trigger") -> sh
      where sh's parent is the app.

  (b) Two unrolled rcu_dereference()s -- current->real_parent
      and that task's real_parent. Still no loop, just two
      fixed dereferences. Covers the common indirect case
        service -> library -> system(...) -> sh
      where sh's parent is the thin library wrapper and the
      grandparent is the originating service, which is what we
      actually need to identify in the field.

In both cases the RCU read is a fixed number of dereferences,
not iteration over a data structure, so the total work is
bounded and constant.

I lean toward (b): one level is not enough to reach the
originating service in the indirect pattern this patch was
written for. If two dereferences in the sysrq path are still
too much, I will fall back to (a).

Which direction would you accept? I will respin based on your
answer.

Thanks,
Xiang
