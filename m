Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22315EFA1
	for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995068; cv=none; b=PypqaYO6a2G14u5FSBnDWjVvYrskSewftNSjS0j/9RXPHUXcdpe6a+UDfchzvUNS819JNn4aGYqyobaZUqrmJNDMmy7he/kJjiSlmFz4MRfZWcXmr4Je9xC90OWd1d8FBtNzZQp6QF0SQjP99muzgQh1IJ1dwFZCqAA7ciV+IYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995068; c=relaxed/simple;
	bh=2VSdF3SoVzS+CZe0tPuaFYN1p5DVzjycpcTzKsXd5Pg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=vC65swPidcFzjK8adIrZ0Tw7+pdEL/9blGPXdwY8sk8ddw7i7ft+BmJR081bSpD3Kfra2Qds8UM8zTi+MKJL2tEUFMXu3Bt6BYzOxnw+1fwWzPP1VEbexnN/5sRs9WpPET1XVnPSwF0hC8AAtA8UWcffQnOIQ5saQvnbK8xYOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com; spf=pass smtp.mailfrom=geotab.com; dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b=oEs+RczT; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geotab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b="oEs+RczT"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3a26de697fso6822238276.3
        for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geotab.com; s=google; t=1737995065; x=1738599865; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2VSdF3SoVzS+CZe0tPuaFYN1p5DVzjycpcTzKsXd5Pg=;
        b=oEs+RczTm+xekwg6nJfzRQ6nRYg07JIW/xwqzgAbaml5Jf0JVNSOh/rjUd17EhED8L
         9hgH92cJm8BLUFh8njklLxybtgaPyQxphPkl65M/10+Am3eIPuKvbY04M8hzcOJsgrwk
         KbAARgcd+Hg1ompWCqIm4s5FlJsNB0tOuBaSuhk9YA9RyivFb03Jyg5PXyGtgJMYpsFd
         jECwQ76dflvqzeNyGF+PFrJL8GBh/55sHiI1RWFEE9KABpBdbFGjryHRTOvKo3s/Ysmk
         JaWqGv9/TfnuXT7F3tX61MNCBphtM0a+OUurmteGv+lxjp0MT+dLaK1O4Jr9iZH6xSci
         MClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737995065; x=1738599865;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VSdF3SoVzS+CZe0tPuaFYN1p5DVzjycpcTzKsXd5Pg=;
        b=LHIEpX6qpxAS3H0vo+R5YkBKTP7zU01eiE12DPBHTsrU6/h5Xg5RSRtB59uApaWNdO
         nWuTTdE/KNm4V/qU7hQVDGBxGylCeYyPbsBulxZKmGcGRyzli3yVZrdgNkN23rjIDLm/
         Hn6As0c4ECEnmJthRJb44arEvlBo25IORHVZr0wlFBKRgP5OgkV0ugx23u5ULhZKRFo4
         wNjnjjILfe3SIeBydZCu1+yM72BRgtJHDiyhgvIC2ZgcTBl3BQuHBFD6TSjHzevsxHWd
         GBsRk7BWuYvFg3jCcJNG0xUHK4tEVi9QN57XIl2+jRzRz7Bb8RVTU+r/iVUiAqf/M8sv
         Ux7A==
X-Gm-Message-State: AOJu0YxZmTZaxCBXaITQJ4L1iT8DY7ne736NJj6kQVg7pClV8YVEWf0i
	NqEhkJFkahgwy0Z6BNX/3ftQhkA4XKAJcPqxptv1shHCffxeonoHbdbivVIR+1ah1rKVwUm0334
	7bcZ1A+nk+r6G7d2ubk9kCndgKwVTXPU0GpZy/9pdEa+/zewDyoUDmg==
X-Gm-Gg: ASbGncvxnZDyU75zOddvEGTPh/fsdI23c2C4A5Uulh1kdoXShnYZb3H7lmFPexEBu0K
	91xBMBPZgfz1EM6laDzzmKklLjq6zaNfVsmVNDM1+YkdHqsFo3isEuEI9oZxOISc=
X-Google-Smtp-Source: AGHT+IE8KLgbvC0n7biYMOuN4k8R0h674oo7EEs6l7IeSQjfKMUbe4EHJB+vYFocjPzC+RiiSShD2m+KVhQJgqL9N/0=
X-Received: by 2002:a05:6902:124e:b0:e54:a0b3:fb40 with SMTP id
 3f1490d57ef6-e57b10642b1mr33184046276.20.1737995064783; Mon, 27 Jan 2025
 08:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Lizewski <daniellizewski@geotab.com>
Date: Mon, 27 Jan 2025 11:23:49 -0500
X-Gm-Features: AWEUYZkcEbm5OorGZkrfv-rUwHCSaXy09z0f2cRjAtBznso7p0BgEea2Vzzhs3s
Message-ID: <CANYnu5-4Vzsp7jbOZ-ZeQx_0uwnP5RUMLO72DOGqrsFbLO0zOQ@mail.gmail.com>
Subject: BUG: n_gsm.c: Deadlock in gsm_modem_upd_via_msc
To: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I have found a deadlock in the n_gsm line discipline.

In the function gsm_modem_upd_via_msc, it sends a gsm control message and
does a blocking wait (gsm_control_wait) until either a response or timeout.

The problem happens when a modem update is triggered inside the
callback for incoming data "gsmld_receive_buf"
gsmld_receive_buf -> gsm0_receive -> gsm_queue -> gsm_dlci_open ->
gsm_modem_update -> gsm_modem_upd_via_msc after a "UA" response in
gsm_queue.

When line disciplines are flushed in flush_to_ldisc,
there is a lock making this section of code including all of the GSM command
processing single threaded.
The blocking call in gsm_modem_upd_via_msc (gsm_control_wait) can only be
satisfied if a new GSM response is received and processed in another callback
to gsmld_receive_buf, which cannot happen because we are blocking in that
locked function.

The code eventually does recover after all of the T1 timeouts and retries.
At that point, all the responses which were queued up but could not be
processed come in, but the state machine had already closed the connection
and is no longer waiting for the response.

I believe this is the only situation that causes the deadlock because
all other calls to gsm_modem_upd_via_msc are initiated through a different
tty_ldisc_ops callback.
This deadlock only happens when encoding==GSM_BASIC_OPT, adaption ==
1, and initiator == 1.

This call was added in 2022 with commit 4847380.
I believe to satisfy:
"5.4.6.3.7 Modem Status Command (MSC)"
"This command shall be sent prior to any user data after a creation of a DLC"
of "3GPP TS 07.10".

The code doesn't actually do anything with the response,
since the response is just an echo of the data we sent,
so we could simply just not wait for the response in this case.
Or we could make it a new opening state and process the response async similar
to how CMD_PN is done currently.
