Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115552;
	b=OLgj9MYPCbLUNrYwqBl1YC5e9yJbD7tAeM8yeFTeh0parILv7QWdMjsXm5wJU/qtwGvY
	 DQptQ3PGfx2/jTD9u/7mzxcNbEK7o9as5B8YUu6aN8uan2kLXowDsq8+xi31CPUAeF1Jp
	 to5sOYlC5lpIsEilN6QXlmFnbnUCmPZi4P9NWOxCU5jPhn2JYQTFkyVXp3FVVDlJXwq/q
	 5dtfM/wN+1gyUahNCWEWLc/oP+JUYh+Nm2XN11RrWGJ85QWBNneDf3RjtJOAuJaVMNVFo
	 UorV6xmGdozE5WNbIZNWtIDXU7GOKmu4rZEjv5OETMO+D/MH7qkTwa3GM1BgOj7Ehag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=8jh6Jxx2tdaMexEWwJuCJFDK6A3SmElL44H9Ig/Sa8g=;
	b=RNpk+V8lPGineIKcZC/jsuzrpv9Tsj53wUjbJ90B6pyvcmCIAUREhZy1G8tpcIMbP91g
	 d5MQGUY77z5fqkGX6ruRBQ1CgDid0wxp0GO/Hg6vLoBJseUHqVFHhe1Bkq6zL98kzQ0eB
	 NAjCTZAzX6BZi0SzKcYzOh/MRc1yBS0MxWDtaOzdQNa3EDS+qAiCcFHb+NrMrKPeMxnNS
	 aO7WFziNyaOPYph3521eNXGC27ub79K7tX7G/k0zCJ46kEbEgrTG7YjXleCTy4imvdFVH
	 j7QQk94iGMN5d2ckB+YBJEVViYxE8Dro5VywpuM/2PZp6I8SDI1DQZbzGjviO8wGyzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TWRPRyWw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA6606B546
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65AA6606B546
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TWRPRyWw
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-824f3901d55so4607328a34.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 08:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793115551; cv=none;
        d=google.com; s=arc-20260327;
        b=kP1j40HWK5XVaft1eNVemobq6/O/vmHozwI+RNzq4J6qyViqwC78b2xHIhdBtKvgz7
         DsjJtEYv/WeOhjEp1CYJ/DQqit0T7GH8ZXw3vvA+8hEIoxKd+xX8dpmxBBdWiknE+GZb
         rxz7jXnQObadS7TkvOkUxq3+tHjl+yXHsGS9WkVQBjm01FKp78kP6hX5iktHcvDBbuiI
         SRQRNi7OQFgufb9qdzOT5fjMuJeFP2aCgAUPArcCBbcAUn+Tam3v77G1AnjdKm02aqay
         ymzDx390VgYfPq3GEPeBbe373M3a4CmC6qn2IKqYilOxDSYzF4HL7cZv/wnDZj93RSnA
         iC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8jh6Jxx2tdaMexEWwJuCJFDK6A3SmElL44H9Ig/Sa8g=;
        fh=/QP+n2O4Hyc4wPS4zFFRlhIZQ4uvqm/l12+HjjpmfsY=;
        b=EbzHOJwn/sNpXC2tj30S5J2M0SJ08HR9v5FqcUPW0PPbpJHqnwQxzsmrcvW+Ksid2N
         st3sGoggaNEyt7GfBsk9x3UTT41pkC+bwGnGovZgh6qBXupbPBHKq8CnzBBFZrRJzCc+
         wNMBa9YGo7e1WYdRLPk5ayipJw4lY8GbWjgym4sIhTvuVkNGTEVNM1arpWX6xVYyZegQ
         SjFnXhcfK0IrasBxBy0qXTRpICVxQM9F6wHHSgIUdci1EDqXXxdsrHAOHUtre8bmlXA7
         qiAq4orYfEmaleVBHYO6GF+B7qJfUesnHV3ld1LZYQlWmX4Lo+OR2iXbH+1DB5sRGMhY
         nPpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793115551; x=1793720351; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8jh6Jxx2tdaMexEWwJuCJFDK6A3SmElL44H9Ig/Sa8g=;
        b=TWRPRyWwRvT9KN1SX1ipIDLNUcglENvCzW0/dWldPpg0LQQG6/eDRPSBzr+90eRZhC
         Fb0Rr75ofyTJj5iChItBr3nngovAyb8MTlZjcxWSCqEg8748OFYldrX1+nyB4AjIo+f+
         UKG+yKLc9vzSumqRFb+5o1DBzY1I73Fa++K8sXvgtN154LVOlHshZfjm6+FFzK0kEtE2
         36KFPOOS2GTXQGh7jsLO3VJcWKKUtarX2SSNNDc0BHo2Vn0msdcnT3gG6H0g9A7mf3rf
         w6SUw+WaxTx74kRZbFDol3D60fUESuOdWkXJtAbisMAG+RcAwPSCetCx9l7aDM13r4Ru
         Aa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793115551; x=1793720351;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8jh6Jxx2tdaMexEWwJuCJFDK6A3SmElL44H9Ig/Sa8g=;
        b=jpTfRi1BIQWYZCTJ0T8jUbMVCLa3CiHm2hxr5GfADjOXaNE8P6QIa/cDglNRlzqTIs
         d1wSyleSyZ/XVt7F+oR49SrFD68N0aNLOfRswWhx0tGwW8WWKAtNnpowQfPbShoKorLM
         cSb9GoOWext1G5EWB+8Cp7T8zwh5NkubFjnVx4muqfeacrP43MM7pbGlw3rWyyhkIgVk
         qMDXFPIb+mbJFqW6sjDQHFj8odkPuQlmF7HmdmeVBUnPzP9dlF8AvNDlks9AIJpMigAV
         Hg28aDz2ffPNhMWMk+JXtpmSDGUXaAmsVwutAK43O/3d1FwFBvz9KDWwp0D4yxxoySf0
         7zUQ==
X-Gm-Message-State: AFq9FYKJoo/KkjMmsppC4fNQesL5CoAQGgUcE5qclKSHSWF5WVYaq5lZ
	YMAvVWeKEVZRbjukuAsiyqrNquIxg7/Ig7pMGfshvMTQPL5qs7VSxaO1OmCgQrK3XiVikxjA6R3
	FCnePyFfjO7BhWckR9ScLFCKxX0tb0WEEALqt7yR0FA==
X-Gm-Gg: AYBFou2Zd4sY215mNBTGf6OuvXEdke7lAxW8z6LC07VGXEkTphMzbjHFc+t7E9ets7n
	XsULijAigyVvu8LTi95hrSeDyRLsokPTrqRnuBHDrHnPrpm8bcEoj1NTDqy4x68ORDGMLpQYUV+
	vYWBtQOdpNhXt24vk6eNCcos3/Yrc7lU9oYesVVJFulSuXDBkS0IqtYLlFDKh09RQV9BJ9Jbhtk
	jCoj14UVgc15S8yaQt6G1/UEnIw2cUEe8FSJ9K2YM3dTFLA9i14lxclv5Nf/KQPSzvYCkZC0mkG
	UDMsAhWYKva3VeoTBZr/odTFs5bWkRj+W5BezwFWPWGvUu7VdnvNVIR3nJI31eSPbiciZQR+SEK
	i3iQmONc4ZDX62fqUat4HxlygPzpdDGM/JskkBndZBIVWCfKOFzFdVin7ng2fSk2GwsR3G+uC
X-Received: by 2002:a05:6808:1b0f:b0:4fb:ac9b:b07f with SMTP id
 5614622812f47-55c003891c1mr6060735b6e.49.1793115551041; Tue, 27 Oct 2026
 08:39:11 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082236.56724-1-dennylin0707@gmail.com> <sashiko-outbox-186286@kernel.org>
In-Reply-To: <sashiko-outbox-186286@kernel.org>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 27 Oct 2026 08:39:00 -0700
X-Gm-Features: AclHuK-mmp76fq9pZeuX5A4D73PpytefZnzEC0dLCyPSsykm8KnPnRBRfK6MUvI
Message-ID: <CAGEkeHeOA9HOKQXwLmbHRfq5uCAM5DnGXcyPfAX3h16xA2Q6BQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: discard flip-buffer input for TCSAFLUSH
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Sashiko has reviewed this patch and found no issues.

Please disregard v2 for now. Further testing found regressions with
PPP/SLIP and a locking issue with VT selection paste.

I'm still investigating and don't have a replacement ready.

Thanks,
Hungyu
