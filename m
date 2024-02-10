Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8FD5FDC2
	for <linux-serial@vger.kernel.org>; Sat, 10 Feb 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602633; cv=none; b=Ae+NWGbdPJKHdIINtTNZo2Gi7op1y461B2rrjUSImXI/Palr+nhTnAWKgqAU5XwFrcQnvFezCOzX6qcNfuh8ndb4OjgYay2jgCVGsTGuap/K76YBGeGNNm+4N0Jmtq+m6Pv3fORjFNLAmHCHDWHPwx3swJyTfv/tkMVcpFnWEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602633; c=relaxed/simple;
	bh=hLmnNXrvbMNc5JxbNyHF5osHJhWyPyvIHRuzwIaryUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOj20DqXCu1o73u0fVTumcqyITxdDOZQtgPPrKGc/m1nT162Wm+4DCTohLDGbwg9Rhz5kr3lrCpKn5DZ4oz54Q3Cqoe2AQwi5UoI74OsblAgeq8HVB2yDatbVvhX8EuHl15w8BxzMmo3dkMIQ/SuvKZf1B6IfkQ5uOri1iE75fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZpCEoh1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZpCEoh1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b28aadb28so1174122f8f.3
        for <linux-serial@vger.kernel.org>; Sat, 10 Feb 2024 14:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602630; x=1708207430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJMk4VOe8w/iZK5IGmLwHjbpqGC7v4wZlxxjo91BQxs=;
        b=gZpCEoh1QSc/mpi+5NpAxu5FqwMj4Qm/OWqmkKOQ7nbkhd1F9uljp8ygFCw3DB6XfW
         qMxFMk6IRM8KuZRh1OJIVozGxfAl5MntXm7UqoDGofOgXvpcxIvFWAK6o2gCjCcCUO6h
         KGjeSVpr1NdYuDtuIwjoGobR4y/J5edSlNKvdA8z+d8BpInG9YZl2F8oAmBLVUeRMBam
         6oKezrmIl6yeSz7V6V37VaLVyT5k+p9KP7H5kZotnO9zLmSW6J4ddJTKZNH/YAt+vk9I
         oM2AvU3CYkWG+c2zLV0krLs7/GegZamAQNI9eCRSFSz0NwYfN0C36MV7VaxgUOHNlgp6
         DZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602630; x=1708207430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJMk4VOe8w/iZK5IGmLwHjbpqGC7v4wZlxxjo91BQxs=;
        b=Ehwzb7+1JVmTY2XVABZ+E4vDkE9Po4pbfJXKICEQMkMiR7FVbLo2J9YyC0+gqJPbaa
         AX/PPNhYbIMSIpyNts62LsCtk5ywdJamPO/1d/xeEV9Kuo2AUDpNyi4JE+M9G9pxiUWa
         gtXDvdzQUuss7RGzYlUiRfRAkHU/iJClb4VqMSiMSG5QNC5Qun9SbRHTQng6meWqBG1Z
         cdIi0iKfy50Z3HWAhybe0tHz1SBodSx0M/GcNDh8ei+2wzg3pTWRuiBZjPTbYH07PP/3
         8GOuvnRt3AA9Y0BJWdG848k6Bfn3ykwzN0M0U3wBMCbHtMyBpVNtjhEdffoMJ8o2UoEo
         kGGw==
X-Forwarded-Encrypted: i=1; AJvYcCW9EZWxL4Osvd/3B+oHxKkSL6cdy9FZjdunQW/le29abovFgj5+MFhViTWfAy9ozKcKANsirPMHcEVfzQftFl0HDmKqgq/o/rfKe16e
X-Gm-Message-State: AOJu0Yy2u6CgJVzKTxYeSbEfGgzG1wD8ZEA5Sf71ffD+YkxRejuWlmw0
	f8n3IPllw2zyBjlLk05W6wUTJBCRwRq7rs5GW8/ULagOPuboukp8
X-Google-Smtp-Source: AGHT+IG1R4BMlcHSfKPiKEiU9iGz+UYYVh2OvA+kg2/wmQlsPa7hOMVKihK5aOBqaEGO6R0xwa0x/A==
X-Received: by 2002:a5d:4987:0:b0:33b:3ad8:22c5 with SMTP id r7-20020a5d4987000000b0033b3ad822c5mr1798014wrq.68.1707602630004;
        Sat, 10 Feb 2024 14:03:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVucgIu1mZoSfgkU2cUXYsn3GqpyKyYBvJhCNyrDvW+qjlh8Rzo8y+Zjy7iv39/De86QcvBA8NQasHX0NejpyIu7MzsYdSEkqCaoQRy4vxTr5DxIuXOsiJjeoSb25q1DG/322+1pq67HX/RqPsLyEUhUROZ6iGGUXt1L0BlMz/AGAxLP4qhL1cFPeAKjA0pIgMAhX15HPXhPq2mn0Hw/ilPRcathxwGS1Y3EEd7HaUGhoOor7pvu7P6qIFg+nsokJ2JCglyTuawV/JtM2rZT4qR+DKQiKs/WrN2Zl7QMpaBEW5PnmSqZfEQfby2MUwGgvzIxU+GEc8=
Received: from m2 (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.gmail.com with ESMTPSA id r10-20020a056000014a00b0033b1c321070sm2779618wrx.31.2024.02.10.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 14:03:49 -0800 (PST)
Date: Sun, 11 Feb 2024 00:03:47 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Christina Quast <chrysh@christina-quast.de>,
	Jiri Kosina <jikos@kernel.org>
Cc: daniel.beer@igorinstitute.com,
	Christina Quast <contact@christina-quast.de>,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <Zcfyw+vjb+kNBnCC@m2>
References: <Zab4g5PnwcaferE9@fermat.nev>
 <Zag78CurQQGSLDW3@michael-VirtualBox>
 <ZawT2Onn23CPMeWa@michael-VirtualBox>
 <ZaxFkPY3W/5SFwh6@fermat.nev>
 <ZazgFniD3qXGG1cY@michael-VirtualBox>
 <ZbbQNEC8pWlkshgN@m2>
 <ZbnoiUhM7sOt7/a6@fermat.nev>
 <Zbpr531rSxCsDKck@m2>
 <041c7445-fd59-4615-bb9a-7958b93113e8@christina-quast.de>
 <ZbywCMJyHV8dGRSV@m2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbywCMJyHV8dGRSV@m2>

On Fri, Feb 02, 2024 at 11:04:08AM +0200, Michael Zaidman wrote:
> On Thu, Feb 01, 2024 at 02:03:25PM +0100, Christina Quast wrote:
> > Hi Michael!
> > 
> > The FIXMEs should have been removed before submitting, sorry for that. They were just a reminder to myself to check the kfifo spinlocks.
> > 
> > The code looks good to me! What's the next steps? Should I include your uart related changes to the patch and resend it to the mailng list?
> > 
> 

Hi Christina,

I did more testing and published the changes here
https://lore.kernel.org/all/20240210215147.77629-1-michael.zaidman@gmail.com/

Please review and meld them into the v5 patch.

Thanks,
Michael

