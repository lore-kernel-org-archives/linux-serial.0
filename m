Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6719309E
	for <linux-serial@vger.kernel.org>; Mon, 26 Aug 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686842; cv=none; b=sGTzb5X6x/NA96UqlsGguI1kbDY8fDtV0tGsySq4XVqs2Y+27Y+JbBAr+m4myx/m/i8kQ4NgfapKQ4v44caHULDuBgzAihQiNbFy8j3SguExOcSGcoEHb+TKVO38s0qq+PoGIlEDjZnIYX+kOmBceDZLmc/IT8ykh/ogQ/gEu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686842; c=relaxed/simple;
	bh=yYY+MkVum/mgf8ScKM6FEHNFcqOg4GHLmlQnUF2A6H4=;
	h=Message-ID:Date:From:Subject:To:CC:MIME-Version:Content-Type; b=p8jkgRshwbkqiiNVB8yWfSUSitBifRCumMFheIFGvW+cNSRruJCxhc2dfsFwdMVyLkvbaFD+Z24OaPQE64nLlsekbelPsxxQl/5Z6KQmTfBuvEBh4H59pdY8mCfcdD4eC9s5O4wFR2rJHgj4ChG9D1asJCE5041veLtcoHazdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=FydNOSwp; arc=none smtp.client-ip=185.58.86.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="FydNOSwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724686833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mI2LOjmi14onsWWfDo43NtnPS8cWarwfRKBC2q+k+z0=;
	b=FydNOSwp15g7qz/Xb0Hz7vBQZuZo3uKyF32ziVkfuNMeLgohRSDYETJWlybwXADCYQRXzB
	Ea+wPPpu99sHM0oqna/n75RqN5pnbK8wvT+kQGcl2kLmfbLMdjRHLvtd+wMtzs8J5337rc
	ERsHXaYwJ082TvlIsMwgx7/yuUEt2eM=
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01lp2105.outbound.protection.outlook.com [104.47.85.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-75-AmDJ0nVhOu2580Zfp_rBDA-1; Mon, 26 Aug 2024 16:40:32 +0100
X-MC-Unique: AmDJ0nVhOu2580Zfp_rBDA-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB6192.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:40:30 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:40:30 +0000
Message-ID: <9c1f8fd4-a2a5-4f92-9e86-2cf0103b1908@camlingroup.com>
Date: Mon, 26 Aug 2024 17:40:28 +0200
User-Agent: Mozilla Thunderbird
From: Lech Perczak <lech.perczak@camlingroup.com>
Subject: [PATCH v4 0/3] serial: sc16is7xx: cosmetic cleanup
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 Pawel Lenkow <p.lenkow@camlintechnologies.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 151bd377-7fc0-4307-d0f9-08dcc5e56a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?azQ383iqhYwuWfYyF76UqClN2WvDsoZpolJMbGuIU5flW8n7qJr3nnKmnS2K?=
 =?us-ascii?Q?U9J7RBAAjq7KpktXukukQmUl93fiLmvXHu5VEOABtFZXRvJpqqz1kCk8ULZi?=
 =?us-ascii?Q?DSbvsRgXWg0CWS9cBeQnYYWsugWltEe7M32ut4FLSmJafQWUhws/ZNl5QOHC?=
 =?us-ascii?Q?nwqKYh6759zUtg4y4/iLY64i2tp9xYbUscHlE/YgMiniuTgwrzRFbXlWXXle?=
 =?us-ascii?Q?TBExIxMy1h93zLjsL5OruMcxL3wAQl1Ybbv6i5vrQbFvbKLp67n9lvxL175P?=
 =?us-ascii?Q?mga0Cq5G7mCGv0EdFpPWh1ikfeN0i2HI/fCvNJMUf77erVBN5XnNUNd7cjJm?=
 =?us-ascii?Q?amNVa120FccK+YWSu0QiJAkzFV7x1ZTF4Jmfeekj9KkxHZ62wpbDLqIZJQ6F?=
 =?us-ascii?Q?s2wy0BGv5A4v210kOGtiAP0RBt/QSkIdPaZ+D/T0yf4wU3enmO1pU12lNlD6?=
 =?us-ascii?Q?cgDclIeNbJ2F72IGockpW/dVcmEtDHsWUwoGDD9VqOOx9ouS+HfOakf5Z5qe?=
 =?us-ascii?Q?RfDuv0JCWAkmXNG0KvHAEbIcNtjRwKIw1/1p5lc7VVhOEDJZ11NI4fAceZlj?=
 =?us-ascii?Q?FhWLL146KuOjouHlDiRtTWYU2TZAnxgLfi1Lfqs9zfB49YQDi6LoyF7oU3uu?=
 =?us-ascii?Q?7Lw2bIcN2i3XDPNW2oIK/fld3Rr2Rf2kpc/HGjJ1ha7bnEDKX+NlxtCYu34R?=
 =?us-ascii?Q?8YI4musY3dmFj6evJVv7YF+hprI6Fky7HuxPVpKMSSxiyhWL/tNrRZgG/m0p?=
 =?us-ascii?Q?7pgVi3eBvclwmRDB3lsV3OhWL7Y8HIu3QsvufuTAnIbxVqWKVu56GiLIBh+Z?=
 =?us-ascii?Q?1p1wV9piZgyc8KkBjt5EQt9ruHNdwrIsVYnBj7FOJLF6sPlKK0JNLiFScSMX?=
 =?us-ascii?Q?7dysT5gi+XiXGq7XmnjmwD+T69zaChilN+ovA/ogpOPcJR4KZFAa1r6xmqBM?=
 =?us-ascii?Q?lFrRDesgy27x+geGgg/Se13loc8MahM5GlBjkzlFMXTetCAZ2iHDMi0N9DlK?=
 =?us-ascii?Q?CRHBxVIcaG/8cfrkf9ugBhXESOHcN5yGPQEBKU/cNyfMT3pIwnk0GKEtY8ph?=
 =?us-ascii?Q?tHkmeIe8a1/RfNJg/HmUqMdgyY6i0LdtiJjmbZdUPIzITg+W/ZPYOPWXOtHR?=
 =?us-ascii?Q?yZtyh6Y7JCsamZoODSHzBQzP8tH7r9qRsW6FKI8tozcg7Wv0eW/mdccJlSUx?=
 =?us-ascii?Q?FIy05owlpzqWKcBMPskiIEIJ3owM7AG+/Rm09j2uL8hhYqt1MnwNTGiFwl7Z?=
 =?us-ascii?Q?DBb70epJHMoz8Ofleb6Z8pjNcnvWupOu4Et5DV7XCUR/sJD1ttTEQX5ym7WK?=
 =?us-ascii?Q?saAo9O84xPRZCieKc+WzNMazSV70wDcYhOKzfZIBH2bW9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzLzIwHkEGDDIyfaX6AjpgdqmKC8nUOSQByRvIhuEuUXDDCOFwRXLD+hg7CJ?=
 =?us-ascii?Q?uRmY0/4rckL9B2xEYPpW2dc4jc0adgHsHse5vrkcv48iiFN9DNTOWH3gYyhW?=
 =?us-ascii?Q?2SA4ccHBEn8bUOy3weiJD5cVIxklPYtfh1uP9OWwjO/2kzK/Rie7/VNoYeM2?=
 =?us-ascii?Q?5CVpwKVzNeh5goGgA4vTn9NdYrx+mFP1ydEBZN4dKZ5xf+3uWrX7H3Wa+bG5?=
 =?us-ascii?Q?p6a2lVxpyZ+TIemXVFMoofbO0p/74H1r+bWFLF6zNSAhXolb5T0KVsaeYLBj?=
 =?us-ascii?Q?yARVh0oiYtEjyGESdopt1wA5o0awQaLz0ElE3Tun1Sa9Pg+4SxYdi0rXSFhu?=
 =?us-ascii?Q?Yo3G7i55DXgyLK71dHxy05ZUZFk+/p/kNYVBtcy9C3ZfPqpEJ0lLxCRoviVL?=
 =?us-ascii?Q?Ap6jurh5HDIJsIP0WdzDXR7Ljwycmf5BR4MK15HsXBq675HQ0Q0A73714S+0?=
 =?us-ascii?Q?mGcLc906opnxomgYnGjj1vGTIorbkW6+oDAn7PHR5hbPgzzz+hsoI3pGF/Jh?=
 =?us-ascii?Q?dhUNBzA17+0JRGTYUDpIqD/RJ5ZSyhY3hfUjDc7zUQwUXXOJgXM6PN9ezt7a?=
 =?us-ascii?Q?j6L8Mk8yxnDbRpVeLFCDoRh39qH5ONCyoam4a9mPwMOhP2r1+8SPc0wGFPpw?=
 =?us-ascii?Q?DBoT80kOkejTX7T8VU3QaNNjBqqzLPXvwbNsxJG3IcofeYUuemT4Loq4Esr0?=
 =?us-ascii?Q?IfGyJPOydIQeQhM/k8CUGCX3NBJdlcU1XQmweuoY87CqEIvKsL/ZXJOlOmHo?=
 =?us-ascii?Q?T4ZSp3NYbicI9AA+KNTEME0xHp+YYns4NPtPySEAUYDOTCrZRGOy300VV5fZ?=
 =?us-ascii?Q?U5zetMbhZdjaindQfhBFFeyY7vnwLHhKA+cRdTlauNzH6L1rQkwn21AXLpiS?=
 =?us-ascii?Q?NqYk5okzs4rK9uOkztJ2M3YV0EeO7/ma8lY7PSL2dxyo2zZuAbhiczyWs+PX?=
 =?us-ascii?Q?U6dNjb4vzfNK5P7eqJikU8XXcIaMab3j9m5oY2GkMn0vUmZwmvTdpwYh/vR2?=
 =?us-ascii?Q?+gXG6BfQa38tA3mLRhTmFFTC5M/XWXhc6K5BqngLnPcHbCcq8Zq8CsKzavRx?=
 =?us-ascii?Q?bkJFFbHz2NUACiYuOj98ooqH1OXg7jSTNyWjEEXDDMXlWsBEhJVqvcogxsPH?=
 =?us-ascii?Q?vCZJ6zpQecb3mONRGl3Nx5GDWMPwSnqvsdkfvy9alnoYeSezj2TU6QPsrPEs?=
 =?us-ascii?Q?+IHM7h6l513qdlbbs1ecEIIEcl+NRlj5s0Ib+7ZRuQnk45AIapGR8BcuKs+s?=
 =?us-ascii?Q?TaeAUjSYyXzx4poRiTpuv3ov+ThUl4mQfy7scc1GL+dScJrTP2CaXub24UwO?=
 =?us-ascii?Q?t/DofB54yaY1JAdfmCS3BqKsz6tAkKkywbenqWFxRpChNo0sIYYX1wOLWu6f?=
 =?us-ascii?Q?SWiRaMOc+d/QGAB3PRtSQz+KrwMtokJNMeZr4kRmWoDrHNaBNa49Akq4cXO4?=
 =?us-ascii?Q?+LBdmhdhi5c8yiTCV81lYdA1YV5KlZJsPFd+Gu6CIzgcGGia8tPY2KQl4Tow?=
 =?us-ascii?Q?F/+q27qdIeRspzxRrm/LKXYkNWdfoddW04TeL4MWPXvDJA2rZ4YvhMN+pIIT?=
 =?us-ascii?Q?VeSWwEhjtEM9SlGhanxBNlQhXvDtqVVZ33yLtVZIeH5lpwbEokd+N4eOk3cl?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151bd377-7fc0-4307-d0f9-08dcc5e56a6e
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:40:30.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8WvEftucCrzXpFL4Wy7kyYvNcMULQRroEYj5S4mKGV4+QJODLejx1vbnIRsSNVMLKxAAQ9jFF5yv9uT8hqSI3+nAu7wsopN8j/+GVkCOn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6192
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When submitting previous, functional fixes, Tomasz Mo=C5=84 omitted those
two cosmetic patches, that kept lurking in our company tree - likely
by oversight. Let's submit them.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
v4:
No changes to patch 1 and 2.
- Fix typo in commit message in patch 3.
- Revert interrupt source constants back to numerical representation.
- Add a line break to SC16IS7XX_LSR_BRK_ERROR_MASK definition.

v3:
No code changes in patches 1 and 2.
- Pick up Reviewed-by from Andy in patch 1
- Adjust commit message in patch 2
- Perform further cleanup in bit constants,
  use GENMASK for SC16IS7XX_IIR_* and reuse bit definitions in
  SC16IS7XX_LSR_BRK_ERROR_MASK in patch 3.

v2:
- Converted bitmask definitions to use BIT macro
  (thanks Jiri Slaby for the idea)
- Removed redundant comments in patch 2 altogether
- Fixed commit messages (thanks Andy Shevchenko for
  thorough review)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>

Lech Perczak (3):
  serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
  serial: sc16is7xx: fix copy-paste errors in EFR_SWFLOWx_BIT constants
  serial: sc16is7xx: convert bitmask definitions to use BIT() macro

 drivers/tty/serial/sc16is7xx.c | 183 +++++++++++++++++----------------
 1 file changed, 94 insertions(+), 89 deletions(-)


base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
--=20
2.34.1

