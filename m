Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA5237A38;
	Mon, 13 Jan 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775767; cv=pass; b=Ajmz2+Z9BFpizpS1hETF9cRjgJSm8QVKhl4EHaTZcoONUJYVZzPqCjnNDCzbnetHEC3ewE6gh4l8q2uDHUApVnphYejyR62Gqer0HdUvwInFyeo9kn4QE3LaF9O4JyED3D1q9+vJ+6j2l/7yIekZlVWpgna2/inkTZ1YaMvrt3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775767; c=relaxed/simple;
	bh=yJZLztpcvZRwJPasIUbRVL9hobOTqVHE9FThozuqw+U=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=X14GxuCIlnuvAL/J+TPivlZQhCR7Tu1crdiqEqWY/lvJy3Z7ufncm2+zviwU+aVngWVbz/nizKwwRkl39PGo6EGbDxTrBJrWAcshAx90AUPitivE18hSewFgKC5i4nFE3klEpPLdufBGTmu/K4T+K2sCmrK2qDPC/GRXtBJo3/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=cw2GC91h; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="cw2GC91h"
ARC-Seal: i=1; a=rsa-sha256; t=1736775751; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KwBnDVoDCxViRUdvtlOV5/kQVXZclKdqPzTb25tYh2ckFoLoC4yQHqll+M35gmScs2xKwyww2DVGVxpCW/5hMJCiKANgRWALlsibZCNcm3GECqIc6sDrqHVKqYrpVnfzFbA+Ov0OLzZeRX4WlUuwnlS1YmJR3t7sT6CzJhWd1QQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736775751; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/YPpR/aDr4AiUnIfUw8D/cQx38dc7GnQBiitLa2av1g=; 
	b=Bg0nPqLxzZ3wCIev69riMKEpylECZhx9Jj+2lKSILtDzJDh/ZGJuy/xLf+lEJouZkeN6LpoDJrppmQWc3vIfQV1U+S3D8hWerupJW5kcz/AHWmJqlyjzJGNfqJ1Ay317Kk2zgTNCU5eYrFj7Zb5EENHK/UVKUhCtgfqB2hpdEN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736775751;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/YPpR/aDr4AiUnIfUw8D/cQx38dc7GnQBiitLa2av1g=;
	b=cw2GC91hUBF59hb7yBsNKAm0v5G4ycw4oP4k2ALJ5JnioOAQH+fsEzXTdatMNN3d
	VdpzdYltflHR6Up9VnIVAoUaa0hCQYVrj4m5G+E/q8UtW0WDLZ6r1BpsYzS5XmrReJD
	gGvU4ha5SKuKlJSplsKPYDIcGenmAtm1WAezXpkM=
Received: by mx.zohomail.com with SMTPS id 1736775749560835.4250143330927;
	Mon, 13 Jan 2025 05:42:29 -0800 (PST)
Message-ID: <8b118e93-c159-40f0-b89a-817752d11627@collabora.com>
Date: Mon, 13 Jan 2025 18:42:55 +0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com
Content-Language: en-US
To: linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Subject: KGDB/KDB running over internet as serial connection isn't possible
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

I'm new to trying KGDB/KDB. My test machine doesn't have serial port.
I've been trying to run it over internet. I get following dmesg log:
KGDB: Registered I/O driver kgdboc

On test machine command line:
kgdboc=kbd
sudo sh -c "echo g > /proc/sysrq-trigger" # Launch KGDB

System freezes at this point meaning the debugger got activated
correctly. But I'm unable to connect from host side:
gdb vmlinux
set debug remote 1
target remote <test_machine_ip>:2012

I may be missing something trivial. Please can someone point/correct
me how to connect correctly?

PS: kgdboe [2] seems like a out of tree module for help. But it doesn't
seem to be supported anymore.

Is it possible to connect from another machine over internet and debug
the target?

[1] https://docs.kernel.org/dev-tools/kgdb.html
[2] https://github.com/sysprogs/kgdboe
-- 
BR,
Muhammad Usama Anjum

