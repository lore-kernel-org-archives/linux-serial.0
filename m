Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B52523791;
	Tue, 22 Sep 2026 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066798; cv=none; b=UE0HwpcpMpc8zFaoijY15TLWmKl9z8MmT10+DqUw0byJvKIuwjXxEViFiGqPCqE9ft5D1xtm0JvpaaBM/3CtpYWdLkOrVvjLyqbYWwGqJdcbH1YCyCB3qKlIwtUzsZVR1qs0EuQI3jEcDkYGsYIegQZ2b7nys/b9VrkJOSA/KZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066798; c=relaxed/simple;
	bh=ZNYYHyDoTjq9ruH2pMc+PQRugyOSPe4AkRs5fFJPTQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=tIRcm09ABvCzFeivOZMVeh3PfrV8Di7B8ruLlqclO9NdubMg8uZwcR0fKHbq1X57LAHbsuR34vadMgabb7Yx+fJdVQh+xwmvmdFlWY8PgayvGdcOSbWAAHF4WEhnzVNa/OazJaqXrmQF9svb7WqlX7eOxKJXABHhsSPOWSoU2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JF/Z2oj9; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JF/Z2oj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ZNYYHyDoTjq9ruH2pMc+PQRugyOSPe4AkRs5fFJPTQE=; b=J
	F/Z2oj9v7aECMMjsG1GDp5uhtng06Nzv351AWkLzFpfDA22B1llx2mniq2uvHIcD
	BFZLaHQAVK6iwfN/dc3/5BTd2XD4pVeIdvmKHiAWJz6Wau/KENWWfaY1NXYEP8wA
	MWLyuHMIGznNWUcGTXc+Hb8eKLjlUUJhUd2kPiAcLw=
Date: Tue, 22 Sep 2026 16:45:28 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Linus Walleij" <linusw@kernel.org>
Cc: longzhao@ambarella.com, "Arnd Bergmann" <arnd@arndb.de>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Michael Turquette" <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>,
	"Jerome Brunet" <jbrunet@baylibre.com>,
	"Bartosz Golaszewski" <brgl@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>, "Lee Jones" <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v8 08/18] gpiolib: regmap: add write_data_after_dir
 quirk
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAD++jLkSfPvuO=ZgqwYnbBBjxuu4ns1EDpHXQxKgWGqK9E130A@mail.gmail.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-8-282ff5d98dda@ambarella.com>
 <CAD++jLkSfPvuO=ZgqwYnbBBjxuu4ns1EDpHXQxKgWGqK9E130A@mail.gmail.com>
X-NTES-SC: AL_Qu2SAvyduU8p7iKZZekcn0wRhug/UMa4u/sm3YNXc84FpwPw5QMjZmNDNHL32tKTBxilqxOseRpTx8lTXqZ3sj05Ju8ZRNM+t6w3+JxA7Q==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5360c3b9.7b09.1a0c84a9d1d.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gygvCgDnN1YoQLJq3sAVAA--.40231W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxQhh0mqyQCix7gAA3R
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTGludXMsCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCkkgd2lsbCBkbyBpbiB0aGUgbmV4dCBy
ZXZpc2lvbi4KCkJlc3QgcmVnYXJkcywKTG9uZyBaaGFvCgpBdCAyMDI2LTA5LTIyIDE1OjE3OjQ4
LCAiTGludXMgV2FsbGVpaiIgPGxpbnVzd0BrZXJuZWwub3JnPiB3cm90ZToKPkhpIExvbmcsCj4K
PnRoaXMgaXMgc3RhcnRpbmcgdG8gbG9vayBnb29kIQo+Cj5PbiBNb24sIFNlcCAyMSwgMjAyNiBh
dCA2OjIz4oCvQU0gTG9uZyBaaGFvIHZpYSBCNCBSZWxheQo+PGRldm51bGwrbG9uZ3poYW8uYW1i
YXJlbGxhLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPgo+PiBGcm9tOiBMb25nIFpoYW8gPGxvbmd6
aGFvQGFtYmFyZWxsYS5jb20+Cj4+Cj4+IFNvbWUgY29udHJvbGxlcnMgaWdub3JlIGRhdGEtcmVn
aXN0ZXIgd3JpdGVzIHdoaWxlIGEgbGluZSBpcyBzdGlsbCBhbgo+PiBpbnB1dC4gT3B0aW9uYWxs
eSB3cml0ZSB0aGUgb3V0cHV0IHZhbHVlIGFnYWluIGFmdGVyIHN3aXRjaGluZyB0aGUKPj4gZGly
ZWN0aW9uLCBtYXRjaGluZyB0aGUgZXhpc3RpbmcgUEwwNjEgYmVoYXZpb3VyLgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBMb25nIFpoYW8gPGxvbmd6aGFvQGFtYmFyZWxsYS5jb20+Cj4oLi4uKQo+Cj4+
ICsrKyBiL2luY2x1ZGUvbGludXgvZ3Bpby9yZWdtYXAuaAo+PiBAQCAtNDgsNiArNDgsMTMgQEAg
c3RydWN0IHJlZ21hcDsKPj4gICAqICAgICAgICAgICAgICAgICAgICAgKE9wdGlvbmFsKSBCaXRt
YXAgcmVwcmVzZW50aW5nIHRoZSBmaXhlZCBkaXJlY3Rpb24gb2YKPj4gICAqICAgICAgICAgICAg
ICAgICAgICAgdGhlIEdQSU8gbGluZXMuIFVzZWZ1bCB3aGVuIHRoZXJlIGFyZSBHUElPIGxpbmVz
IHdpdGggYQo+PiAgICogICAgICAgICAgICAgICAgICAgICBmaXhlZCBkaXJlY3Rpb24gbWl4ZWQg
dG9nZXRoZXIgaW4gdGhlIHNhbWUgcmVnaXN0ZXIuCj4+ICsgKiBAd3JpdGVfZGF0YV9hZnRlcl9k
aXI6Cj4+ICsgKiAgICAgICAgICAgICAgICAgICAgIChPcHRpb25hbCkgV3JpdGUgdGhlIG91dHB1
dCB2YWx1ZSBhZ2FpbiBhZnRlcgo+PiArICogICAgICAgICAgICAgICAgICAgICBzd2l0Y2hpbmcg
YSBsaW5lIHRvIG91dHB1dCBpbiAtPmRpcmVjdGlvbl9vdXRwdXQoKS4KPj4gKyAqICAgICAgICAg
ICAgICAgICAgICAgTmVlZGVkIGZvciBoYXJkd2FyZSB3aGljaCBpZ25vcmVzIGRhdGEgcmVnaXN0
ZXIKPj4gKyAqICAgICAgICAgICAgICAgICAgICAgd3JpdGVzIHdoaWxlIHRoZSBsaW5lIGlzIGNv
bmZpZ3VyZWQgYXMgYW4gaW5wdXQuCj4+ICsgKiAgICAgICAgICAgICAgICAgICAgIFRoaXMgaXMg
YSBsZWdhY3kgcXVpcmsgKGUuZy4gQVJNIFBMMDYxKTsgbmV3IGhhcmR3YXJlCj4+ICsgKiAgICAg
ICAgICAgICAgICAgICAgIG11c3Qgbm90IHVzZSBpdC4gRGlyZWN0aW9uIGNoYW5nZXMgd2lsbCBn
bGl0Y2guCj4+ICAgKiBAZHJ2ZGF0YTogICAgICAgICAgIChPcHRpb25hbCkgUG9pbnRlciB0byBk
cml2ZXIgc3BlY2lmaWMgZGF0YSB3aGljaCBpcwo+PiAgICogICAgICAgICAgICAgICAgICAgICBu
b3QgdXNlZCBieSBncGlvLXJlbWFwIGJ1dCBpcyBwcm92aWRlZCAiYXMgaXMiIHRvIHRoZQo+PiAg
ICogICAgICAgICAgICAgICAgICAgICBkcml2ZXIgY2FsbGJhY2socykuCj4+IEBAIC05NCw2ICsx
MDEsNyBAQCBzdHJ1Y3QgZ3Bpb19yZWdtYXBfY29uZmlnIHsKPj4gICAgICAgICB1bnNpZ25lZCBp
bnQgcmVnX2Rpcl9vdXRfYmFzZTsKPj4gICAgICAgICBpbnQgcmVnX3N0cmlkZTsKPj4gICAgICAg
ICBpbnQgbmdwaW9fcGVyX3JlZzsKPj4gKyAgICAgICBib29sIHdyaXRlX2RhdGFfYWZ0ZXJfZGly
Owo+PiAgICAgICAgIHN0cnVjdCBpcnFfZG9tYWluICppcnFfZG9tYWluOwo+PiAgICAgICAgIHVu
c2lnbmVkIGxvbmcgKmZpeGVkX2RpcmVjdGlvbl9tYXNrOwo+PiAgICAgICAgIHVuc2lnbmVkIGxv
bmcgKmZpeGVkX2RpcmVjdGlvbl9vdXRwdXQ7Cj4KPjEuIFlvdSBoYXZlIHB1dCB0aGUga2VybmVs
ZG9jIGluIGEgY29tcGxldGVseSBkaWZmZXJlbnQgcGxhY2UgaW4gdGhlIG9yZGVyCj5vZiB0aGlu
ZyB0aGFuIHdoZXJlIHlvdSBwdXQgdGhlIGZsYWcgaW4gdGhlIHN0cnVjdC4KPgo+Mi4gUHV0IGEg
Y29tbWVudCBhYm92ZSB0aGUgYmVoYXZpb3VyIGZsYWdzIGJlY2F1c2UgdGhlcmUgd2lsbAo+aW52
YXJpYWJseSBiZSBtb3JlIG9mIHRoZW0hIFNvbWV0aGluZyBsaWtlOgo+LyogUmVnbWFwIEdQSU8g
YmVoYXZpb3VyIGZsYWdzICovCj4KPjMuIFB1dCBhIG5ld2xpbmUgYmVmb3JlICYgYWZ0ZXIgdGhl
IGZsYWdzIHNvIHRoZXkgZW5kIHVwIGluIGEgc2VwYXJhdGUKPnNlY3Rpb24gb2YgdGhlIHN0cnVj
dCwgc28gcGVvcGxlIGtub3cgd2hlcmUgdG8gYWRkIHRoZW0uCj4KPkkgd291bGQgcHV0IHRoZW06
Cj4KPiAgICAgICAgc3RydWN0IGRldmljZSAqcGFyZW50Owo+ICAgICAgICBzdHJ1Y3QgcmVnbWFw
ICpyZWdtYXA7Cj4gICAgICAgIHN0cnVjdCBmd25vZGVfaGFuZGxlICpmd25vZGU7Cj4KPiAgICAg
ICAgY29uc3QgY2hhciAqbGFiZWw7Cj4gICAgICAgIGludCBuZ3BpbzsKPiAgICAgICAgY29uc3Qg
Y2hhciAqY29uc3QgKm5hbWVzOwo+Cj5IRVJFCj4KPiAgICAgICAgdW5zaWduZWQgaW50IHJlZ19k
YXRfYmFzZTsKPiAgICAgICAgdW5zaWduZWQgaW50IHJlZ19zZXRfYmFzZTsKPgo+WW91cnMsCj5M
aW51cyBXYWxsZWlqCg==
