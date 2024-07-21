Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228282CA9
	for <linux-serial@vger.kernel.org>; Sun, 21 Jul 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721562764; cv=none; b=VSI7xdV3dukDonEiWZYPkcNbS0QQd0xvQHCUkFVYq6164f0BdVHZDYFYG9N40x7pPQxEn0+UqWLxXn4DTjF4fukM/CJ8ycQPz0Kemqvxl8YhahL7PQUt3B6BpTK/ALGpeIWerozqSKLs6+1TcFh8efncQ1rUktrwNc9ZbpR1+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721562764; c=relaxed/simple;
	bh=HQbLyEEfWlN4Apyzy/88zfXnwudnEIdcJ9csQUWT6ek=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KX946Kwohsgu/mOzXeM8Etno9EsvixVpQdSnZ88TmNF7WGq07ZKCJiYwT0Sk3sBmm6MH43EmSnV4CnHI+R2R0oP6qM0qh7fU3G+M9JYG7DjBkQf6GS0I8nsoqDQcc/ublsS28r7SoADqJBqOYdtnLuMCDpilt2tKF6flG/j3hRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dOi0YVmu; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dOi0YVmu"
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2222:0:640:c513:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 2A94360AFF
	for <linux-serial@vger.kernel.org>; Sun, 21 Jul 2024 14:52:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VqKwFdNSoGk0-QobogYnb;
	Sun, 21 Jul 2024 14:52:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1721562751; bh=j8nyuK0zqytLh3zLR1pxUzOgvct2bZA5hMsywDPEq+w=;
	h=Subject:From:To:Date:Message-ID;
	b=dOi0YVmuYe5LtwllP9Lf5Arw+VK6WM//DyHJbHzsl0+aWtw0kd7kzkhts9FNfZ6v+
	 mK+I3pTWmXKLW4JMBXt3d3U+zwzVo543YHQ2j98/pgAn88CojFLplgLjquqKkCBdYR
	 ErdP4bSglsY50xuEZBLUw7aAaMXNyvilHQCUP77Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
Date: Sun, 21 Jul 2024 14:52:31 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-serial@vger.kernel.org
From: stsp <stsp2@yandex.ru>
Subject: [regression] ENOTTY returned for tty fds
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

I've noticed that one of my progs failed
to work with serial ports. To distinguish
between real serial ports and PTS nodes,
it tried TIOCMBIC, checking errno for EINVAL.

Obviously that behaviour was changed
and now ENOTTY is returned. Besides
being backward-incompatible, I think this
is also wrong because isatty() returns 1
on such FDs.

Here's the test-case:
socat PTY,link=/tmp/ttyS20,raw,echo=0,b9600 
PTY,link=/tmp/ttyS21,raw,echo=0,b9600

Then run this program:

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <unistd.h>

int main() {
   int fd, err;
   int data = TIOCM_DTR | TIOCM_RTS;
   fd = open("/tmp/ttyS20", O_NONBLOCK);
   if (fd == -1) {
     perror("open()");
     return 1;
   }
   err = ioctl(fd, TIOCMBIC, &data);
   if (err && errno == ENOTTY && isatty(fd))
     printf("Test FAILED: ENOTTY for tty fd\n");
   return 0;
}

