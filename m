Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DE253340;
	Tue, 13 Oct 2026 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883390; cv=none; b=dsMdhJYT0MvoeDavz56z+a19TANqVY4IJPTI+5BZXk94YjIOrd2QdpUroH1ayfBrtmzKb13uJsgDKWTn5AMVMPGFkHGQ1c1TLJhaRAPiLLI6VXd5vRlw3eTSCXCVtHLZsjzIkRTo1C9UQwfqpB55eow0X3FwGS+ogDkav94aGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883390; c=relaxed/simple;
	bh=ofil04HhTpC5obolLrlUT+WOtzfPuVxc9y1abvRUQSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAkYtPt8PgPWM7BzxkAsC5AdxJZ093ZoE2WRAIITuu4cyiRMrrgQBIYqAfmvvacLwMv3SSnROakIIHjyw7vRPolWXUk6PqKm/HTQ6RwJKWA4H0Ckbyrgq0aZFFlAl2T7VqxKDgm2yYQPtzIGa0o3AWAG/6iNf5jFrVMJ+VhRhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNEhL49s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNEhL49s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E61F000FF;
	Tue, 13 Oct 2026 09:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883389;
	bh=7dLuRhyxP4nwjlLQAHA1PhTS/cikBl46Qd8VTWlXOfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YNEhL49syqeDz9UxO2iRTohsddBwkDSOmONbNUTTwQb8W+2yBiuXEdJHLLgs6TbC+
	 HgPMOJfoS407xu8tcYfDZS/DpmFkMGv8dir5K6NTkhw6AQySNyfKWmkFxLJs1qm0rZ
	 TCHpDbojAethdw7LxlRHYJfYOGy1l6+fE/+QQO9qhj1cMFCU+hVK7mg1pLPRpV4xa2
	 TUyH23m00MjeY7B7z++AVGEDsICxPPCNLpnaFfIe22sckAv4hda7ZnhCBTdsANYsCC
	 ux0dLAh5wFBy9sH3N4Smf9a8iPGC2pzkT96xorZZr+wuPcjA8TIncDmvk0bDSzcwxR
	 Z3CP4N5Ug4Yjg==
Message-ID: <56dc6c05-7fd6-43de-bc62-c353ae1dbcc3@kernel.org>
Date: Tue, 13 Oct 2026 11:22:56 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/18] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
To: Linus Walleij <linusw@kernel.org>
Cc: longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com>
 <CAD++jLmKF5XxHsJX29sdXC_6JHKn-7HkE=N+TKtk5xODtQj3_w@mail.gmail.com>
 <b2256847-3ec1-47e8-ac79-ceca86eb09e7@kernel.org>
 <CAD++jLkrXXg9xrhAZ8HETc5Qcv5BbkY-ibjvzBmE5WZVqDEGWQ@mail.gmail.com>
 <a0eca34d-5eb2-4730-b8c7-0f2302bcf265@kernel.org>
 <CAD++jLm=T-U07vAVCogMnfOfkDf=i9QhGGc8ok2N-ZUh50WLNA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAD++jLm=T-U07vAVCogMnfOfkDf=i9QhGGc8ok2N-ZUh50WLNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/10/2026 10:44, Linus Walleij wrote:
> On Mon, Oct 12, 2026 at 9:08 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 12/10/2026 09:06, Linus Walleij wrote:
>>> On Fri, Oct 9, 2026 at 8:17 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> On 01/10/2026 09:03, Linus Walleij wrote:
>>>
>>>>> On Mon, Sep 21, 2026 at 6:23 AM Long Zhao via B4 Relay
>>>>> <devnull+longzhao.ambarella.com@kernel.org> wrote:
>>>>>
>>>>>> From: Long Zhao <longzhao@ambarella.com>
>>>>>>
>>>>>> Document the CV75 pin controller binding using generic function and
>>>>>> groups properties for pinmux configuration.
>>>>>>
>>>>>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>>>> Signed-off-by: Long Zhao <longzhao@ambarella.com>
>>>>>
>>>>> This patch 4/18 applied to the pinctrl tree.
>>>>
>>>> There is a dependency, you cannot take this patch alone.
>>>
>>> Oops, but is it a DTS dependency so if none of the other patches go in through
>>
>> No, it is a bindings dependency, introducing new DT bindings warning for
>> both your tree and next.
> 
> Is there a problem with the bindings patch itself?
> 
> In that case Long can just send an incremental patch to
> fix it right?
> 
>> Your tree is fine in this case as long as next
>> is also fine... but next is not, because that patch did not make it there.
> 
> But the patch is in -next?
> 
> ~/linux-next$ ls
> Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
> Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
> 
>> We cannot have any new DT bindings warnings in next.
> 
> I guess I just don't get it :D
> 
> To me it seems like a fairly normal situation: ACKed bindings merged
> together with the driver, no dependence on anything.

But there is a dependency. Your commit uses undocumented vendor prefix
which introduces warnings.

New warnings:
Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.example.dtb:
pinctrl@e4010000 (ambarella,cv75-pinctrl):
'ambarella,drive-strength-syscon', 'ambarella,pull-syscon' do not match
any of the regexes: '^#.*',
https://gitlab.com/robherring/linux-dt/-/jobs/17038310909



BTW, this commit of yours:
9c2932badcd3e3c0fc630eac5ff2bfd5fadf93f1

does not even build, so a make error.

> 
> But if you tell me "revert the patch" I will simply revert the patch
> because I trust you, it doesn't really matter why.

I think Ambarella won't be picked up, because of total mess with
patchsets, thus Rob should just take the vendor prefix... except there
is no vendor prefix patch to take, since it is squashed with other work.

I don't get why this became so messy and have no clue how this should be
fixed, except revert which is sad churn-type of work.

Best regards,
Krzysztof
