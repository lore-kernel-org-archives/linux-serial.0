Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB26190460;
	Wed,  5 Jun 2024 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569238; cv=none; b=oKCw7Ga6KbZgZ4ym6KHfVUHnEMAHmwkhhLUZFY2wybAMV8xihkWOCAIykYewkrX9CVBBQWSdEO23VtwKqK7n6XedEn9T4J6KO4FOKX5jFFPsAH7i8x2/rDoZGPCnYHl+/NDjgWqsZNinFs+wyPSeGvsnudYftxQ5KSUK4i0Nl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569238; c=relaxed/simple;
	bh=yKGkU7ehHeQu4jI8j591/zMaA76b9Rj77i8p6YUjlRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPRNhzjd+PWXvBZgNfl/vuX03UVoeQa1/l6gkwemhHeaaT/ACmIhRBVO8F2u9pn78LNPcZfkJlC1jk4RhdX4VTxyEbuShoYclDfjK1NR1XSTmXAsGl51//X8YGSPK/CaYecq3w4HIVcR4uakiv9fpfV1xHLEjKwiOMIZV/tYSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GbHBexbO; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GbHBexbO"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A9CE140FA2;
	Wed,  5 Jun 2024 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717569234;
	bh=yKGkU7ehHeQu4jI8j591/zMaA76b9Rj77i8p6YUjlRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=GbHBexbOyxFvYjjTu06ndnFoQb3hUpHcmdR1fIHiorSbaihV9ioZZOxDdNy4HwdTN
	 FyCNt6lMpk++/XmPDtFfMg2v9OPjd+dW6Lh4n1vK6OD5ZiyVe0K2MjcGyDML6cOgwH
	 WHVaIf7dGw5ZVKO2FGiYXN2k4jkieogUxGDvYo7osDo1PnSSsursKBX6UJh1hWlhD/
	 MSU/bYuz7TV+TatLton6aQ14wuZtp6zWlXmURMaFikVx5l/K8m00/QhB+ZC4rl+Dcj
	 pKdVty+bpT/zOdYaivSyOqafvKncr5yXQyVrrNIo0JzZehd9N+nnnOx7XdZgVYVMT/
	 0oqMqFTHbDBsQ==
Message-ID: <a31b8f16-58e0-4eb4-b912-8fc78859df24@canonical.com>
Date: Wed, 5 Jun 2024 14:33:46 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lech.perczak@camlingroup.com
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <Zl8Ysrvj4L-QL3N6@smile.fi.intel.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <Zl8Ysrvj4L-QL3N6@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/4/24 21:37, Andy Shevchenko wrote:
> On Tue, Jun 04, 2024 at 09:27:25PM +0800, Hui Wang wrote:
>> In some designs, the chip reset pin is connected to a gpio, this
> GPIO
>
>> gpio needs to be set correctly before probing the driver, so adding
> GPIO

Got them, and will fix them in the v3.

Thanks.

>> a reset-gpios in the device tree.
>
