Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92B51D519;
	Fri,  4 Sep 2026 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556448; cv=none; b=NXFfhumDZWCsFPtkwmAkUCWcVxltvJvUJhc67KzcgIKn6IBqgoGCaB02ZwAunfIrkV7BuUgpa+VVHKDqIfFV1Qj9143tF236wd6+WCfwn6wx4dr+IxR9NiMmS0dcjBmeedGA1o8DLlvRfjpk2zKpNgsquZnVre6K2oiQaPwxjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556448; c=relaxed/simple;
	bh=oW+8FMTX3fx1YJOkSdZv1ftT3L6r/GyPlfRbiOhQSEU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FSgq+YJNWuxAabqIMGdnl8GzAh7C2JmAHlozNnPGUsi6AOXkmiTBzqWkBHZcHF9pUoVY58KGlsxbtvCcfLgMNRrI9mi0gslGTg0aMGEfKRJKX8+we9Eg4w2lfM6eU66kjB/q5INB2lGNtBNTNH3FSQK3q1ocf3D8OlDfLVYxmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=jaHEBgwF; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=C6/rssgy; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="jaHEBgwF";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="C6/rssgy"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788556416; bh=VBgd6iweLeSAG9K5DN5kIO0
	YGHtnAGmR8ZU1JFZ4zAQ=; b=jaHEBgwF9VbQ68YdeRoq5EtGJ8JTluSZX7YrT4aZE8d1iFuLvn
	EfGIM3GGWjvxJBh4OzGrstHZwEGSoCk63LqsDcg4Vd3E8sN0k3HcsXnuBIX2XHp7ccGhA+2x14E
	sRhyqaS/yw/7RrTfS/VU4OL8RXWqB3rDX+ow7EAVC3mVvooVLcnXm/7bNwc8e4KoIkZaK6OOQ1w
	dMr7hdOF+MUaoyjkvQeq7DSsyzrbhmTE3txZrvloTO0bQzR08Uj8Tc6hfJeciPmgeVml2HB41du
	MQbqe/JOMbccm2wsIVK5IjmLADZRsPF57BQ/7w4dX/5grqRa/qX9/VnxiMobERUo66w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788556416; bh=VBgd6iweLeSAG9K5DN5kIO0
	YGHtnAGmR8ZU1JFZ4zAQ=; b=C6/rssgyouGsbwmXKh6JwZyEC2+4Fz2ZiQWi2ncMRXwzKnEO9P
	MKNNSkgVXVkC5zJEVCOYv/DGxrdJezxs6uDg==;
Date: Fri, 04 Sep 2026 22:13:32 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Jakub Kicinski <kuba@kernel.org>
CC: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Walls <awalls@md.metrocast.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/5=5D_kthread=3A_convert_re?=
 =?US-ASCII?Q?maining_users_to_kthread=5Fcreate=5Fworker?=
In-Reply-To: <20260904141032.34f7ed1b@kernel.org>
References: <cover.1788513591.git.brads@mainlining.org> <20260904085418.50d66b34@kernel.org> <84548BCE-377E-4900-A2EF-177B0CC1B0D0@mainlining.org> <20260904141032.34f7ed1b@kernel.org>
Message-ID: <2AE8656F-326C-40B5-BA11-EB9CD72D2AF7@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 September 2026 22:10:32 BST, Jakub Kicinski <kuba@kernel.org> wrote:
>On Fri, 04 Sep 2026 16:56:30 +0100 Bradley Morgan wrote:
>> On 4 September 2026 16:54:18 BST, Jakub Kicinski <kuba@kernel.org>
>wrote:
>> >On Fri,  4 Sep 2026 09:37:21 +0000 Bradley Morgan wrote:  
>> >>   media: ivtv: convert to kthread_run_worker
>> >>   net: encx24j600: convert to kthread_run_worker
>> >>   tty: sc16is7xx: convert to kthread_run_worker
>> >>   cpufreq: schedutil: convert to kthread_create_worker  
>> >
>> >Please send these 4 to appropriate subsystems
>> >  
>> >>   kthread: remove worker->task self assignment  
>> >
>> >Then after the next merge window when trees converge send this one out 
>> 
>> hi, I was hoping one person could merge it with acks from all subsystems
>
>Not how this works.
Ugh, I've seen it before happen.

Look, fine, I'll do a V3 soon, WITH ONLY the subsystem changes, all
separate, all sent over to their respective maintainers, then when all
thathas been merged and there's the next merge window, then whatever, I'll
send then the kthread removal

IMHO this is a massive annoyance though.. because what if one of the
driverfolks doesn't wanna respond to me!?!
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
