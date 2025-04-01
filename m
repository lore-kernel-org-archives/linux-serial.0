Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazolkn19012053.outbound.protection.outlook.com [52.103.74.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0613594F
	for <linux-serial@vger.kernel.org>; Tue,  1 Apr 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743535024; cv=fail; b=uLebmFnCjnH2hPCtar4wDr5+ypRyQlePQXMa8XndgeC1NSwRB9b9m7ijBh6mVEdbFkqfj59yAVQcTJBEsSP9gxkTtI3UAy7GRrgE1sydWZttkq+dwyImGUbIrTU/hfiS7ltF+NrExdtAaT15oKVn9YfijfFu8BYzyGbrZWRxbYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743535024; c=relaxed/simple;
	bh=ktiU1z9+pe23/fnx1YgD+r0asBec6tRbxO0amaT9zG8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B+5rI6j+DB8ffG0pnoW8L3Xbvgwtthy7wl0Dx8EctgG8iVFEgmLe8d0YZSu2n/bQcq7aT70WdG+H7blLsLPUVJ9N5hDNnQG0v+NCbFpu13vXwwcM/6vYSFfoknX3kQdjWaIp3dKwm5y4SoI27NA+Cv6JvELdJbCCq186FYGkcxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b4vFmwGP; arc=fail smtp.client-ip=52.103.74.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b4vFmwGP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTprKGOLRVceuTWgInKp6o5V8LiTWoiW9qzIm51dFyEoHaePclRY4HfB2v9MYjiqDdZPwAeYA0rF0BOBu/goCZkD0l4/sASa9Hl7ge1drFnXlpRbop7Yg4Ckj5RYB3uPoSCFYH1N4gbxuI+pz075nBltCfhVJ0ArhVnlL4Y2177ybjWGGrL0jfx17nkDUhh/xTDwaEJKQPj5wmZ/wZHh1bhdKBAFUeqa0ww/S8eaKRfyUvcDkaoNkRqw6rFPh4ze+RBnL0QSj4j6EOHqCD+QSNTH7YNN4vzQ3bZKsoxormnP5XtIXjYgwHBN3+UiU6iGZlwtuBNfnng2sijL8NcKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktiU1z9+pe23/fnx1YgD+r0asBec6tRbxO0amaT9zG8=;
 b=DMKtLRvr9StK8+hN6F7SWcR2ml3Tsih00FuxlyUtaZy6dJKIz4xJfjH3AQ8sJlVPTIKAebxbF8FnmILZzwKX18Q90x2uhuUMmstadsL9gizGDu+a4LPD2FGAjvtdygEsvtbqL8KYe6Z7emGDcq80UL8T8Yq91/jce/6M4V7WK6OaZTPEvO+kCv4U6CgyTeKLArg3P4dEOj+tyHczSJYO7bn5eWKDcUnbHyK7KfaM8GWhSUJ2EJQT0fh5YtHNK4mRB1gJfYU6xfPFXHoeypXr0DQunUQqww1gonz7KLwJtH7APKVYy9fqkVV1cSf5pJVfARmpPLMqT6erZv/I1dqscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktiU1z9+pe23/fnx1YgD+r0asBec6tRbxO0amaT9zG8=;
 b=b4vFmwGP5uvXC8qZQ7uCPa3mF2m42ZWRmgreNPo7jD/8DlCyech6YMraoBi6Vp3QuVGIgVkCvgpFqbOFcXxcIMo7umaOnwsGYet6keGZilHGjW6ttewWne0+dNERoELtqdYHoretc2RXkRja2vL4X6O5dVn51XebENrDPaRG1bYTTMkKyidZwx0oZyq7+6cEnf3B78cwL4Utnc3hqiTU6UfFhP5Ab4Qge8/2+N7b5BAT1j0I07hWVKZL3cTO783Zmb8+lciOZGIPf3W3jtOqy28lSVkPw08SQ7wj617Ub5vtyTXTSjFFXXR0femi6EwFfJCzhahvu0SBP0ZyBImAXg==
Received: from SL2P216MB1157.KORP216.PROD.OUTLOOK.COM (2603:1096:101:4::11) by
 SE2P216MB1972.KORP216.PROD.OUTLOOK.COM (2603:1096:101:fa::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.41; Tue, 1 Apr 2025 19:17:00 +0000
Received: from SL2P216MB1157.KORP216.PROD.OUTLOOK.COM
 ([fe80::99c5:912d:7db1:8af4]) by SL2P216MB1157.KORP216.PROD.OUTLOOK.COM
 ([fe80::99c5:912d:7db1:8af4%4]) with mapi id 15.20.8583.041; Tue, 1 Apr 2025
 19:17:00 +0000
From: Lexie Hewitt <lexie.b2bleadlp@outlook.com>
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject:
 =?Windows-1252?Q?RE:_ProMat_2025_Attendees_Database_=96_Expand_Your_Reach?=
Thread-Topic:
 =?Windows-1252?Q?RE:_ProMat_2025_Attendees_Database_=96_Expand_Your_Reach?=
Thread-Index: AduiTon5yZHrc3GsTaKK+JWn74OcZA==
Date: Tue, 1 Apr 2025 19:17:00 +0000
Message-ID:
 <SL2P216MB11572C2182E257BE567B6681ADAC2@SL2P216MB1157.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1157:EE_|SE2P216MB1972:EE_
x-ms-office365-filtering-correlation-id: 279e7284-7d7e-4480-7369-08dd7151c727
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|19110799003|8062599003|8060799006|3412199025|440099028|102099032|41001999003;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?tXUyep0UeCC8tfAYRew+J7+WM93OAUxWe199+eAt5RlEZHJUx+Bl5x/C?=
 =?Windows-1252?Q?hjj6SxV51+jtxAxvbV9gzE2f9yPnNzCGEpjNHB1RQC71dvJLUSfkgXZb?=
 =?Windows-1252?Q?Rn7t5KtXEOpcN3SSGPx6PI9WUd+vi9JjtENBUpRvpljeNIFmQ8KTMPHA?=
 =?Windows-1252?Q?gB85H0m5N3iSO4hunFoOr5Xei4IUgZfkWHocwbyrp4Z3FOV+1eLhKDTR?=
 =?Windows-1252?Q?u2njNGLnxK4FDDPa81W9rtiYUrJDn8Ja+8lKoQiXMqrPWKKM6DBUQCEQ?=
 =?Windows-1252?Q?c0LuperY4HXAAiPiqeyoMeM/bA1OjMLPj+OjoZDYGpR041eF5+YGgdcJ?=
 =?Windows-1252?Q?6SjO6FcRmW760lXPHNyw4KS2I1GNIM1xPucDUAzG/GhcjUXt74IuHoni?=
 =?Windows-1252?Q?/pUy2tuOFnyBipOXAjQOIaFdO7i0vRcZVNH6i+ai++tNKsibbu4yBiJb?=
 =?Windows-1252?Q?3xx0CRd/q0tJ0V5dzxo8uZon4XN36LxEx7iQEpvMe64YHB4WcKhhui2V?=
 =?Windows-1252?Q?SzhZmCYS1zmvjPkuGrqlOUo4RZnT8C9j7t6T9JzSpFa0PS5XEghltRb7?=
 =?Windows-1252?Q?AwQIkXqpqJHhK8/GnMP/V14WsSrXQ0x3OR9FZk0iMRHnWh2ID7WFsVVa?=
 =?Windows-1252?Q?VqBm7E62DvwhFhuAMpR49K42jcLlCnY89m7n+A19kuiG1tIEtcOl2bmN?=
 =?Windows-1252?Q?6JkgxwqtqJWWxkALWwbmELKZb5AZep5EZysX+c89Y2OsMBoRIwcMxBZ/?=
 =?Windows-1252?Q?RRqaa8iM8Lv3Jg7FrSyK/h+Pftp6+p43C43eTf525m/9Tx7evtL/E3QM?=
 =?Windows-1252?Q?wdMPuFhZHl+HlTnEB/A/QfxcxWpa9DsQJWeuLAOXDCwFFJOmVWgXiYF3?=
 =?Windows-1252?Q?O5Xq2uVJ5cYQObDKD/woBZQtcKENyUpS43AgHQr7Ym3YNCXQVu0T42Ti?=
 =?Windows-1252?Q?Ld3Ky0wWAcGfveSQj45O79eaBgQf1FhO5CH8m4mH+VgG5oKLjyPkNLlQ?=
 =?Windows-1252?Q?uy+DYAo6HFOwj5o+85PeQBOWFs4wJtNZRIDskfbx6EWKOAg4+0Y4lIf3?=
 =?Windows-1252?Q?4QD02lUS/yOzk2tKzBczi+8JGTnrI2EdpuUVAtxzYFpljHzP7e12LT2N?=
 =?Windows-1252?Q?0Ygsh7qWzog/BVonGtBd66NOsKByu24oYcaWbF0Fm+Q9Ig3E2gpAX9NU?=
 =?Windows-1252?Q?4UDjrSpFXDQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?JC95ful7Mv8G3amcrLQTsYLsm71JWHc24dSSX9QXhhXlgM8kt1cp3Y3R?=
 =?Windows-1252?Q?cgOISLEIO8R+mcnmXgzmw274E/FXuLDjiY3ZYwpBEKns/8o0li8Av9kf?=
 =?Windows-1252?Q?09W28aW6Gh1Z1ZI/GNloT+wS+tbQFH0kUZgL2xKDOvMlPXBJNadOqVJO?=
 =?Windows-1252?Q?bv4OvZNNVky8zaCVIEEcn7aZiGEavn5IFGemnzjUMf2phD96lJkGuRMv?=
 =?Windows-1252?Q?tNyxVZXsb3VmY6cormF+f+MKMR0snl7OWan7P7qT5ZRwLUHHVepGJjt4?=
 =?Windows-1252?Q?DIJ6V//DckmKYdPptbCOHoD6s6zM865T6r9eREKs6BP3Y+zmcrFR9Us0?=
 =?Windows-1252?Q?B+o7mQswgRNzQYMKywwa26EqL/9MVn0lIQIsKg4Fa4QK3VFkjgtSU3XU?=
 =?Windows-1252?Q?s9eiROchFZL3aNSqRxb3JkWwAhhVNIzMqWo0Ie1aTZPAaYdbeISIaEXs?=
 =?Windows-1252?Q?NLW8OOfA1mmbVkO0bmtAfyzUAA6L62DCMOOTnC+FVseCZL5S/pNWGOWX?=
 =?Windows-1252?Q?+FavJ1tHxTrWEWgnNRo3p1X6IiMTTmPjbGApdmL7aEBmuhbY6VFyvdUT?=
 =?Windows-1252?Q?H5CLMoGtQgVp+t7U0q9Vo+6c391xcRFnLe18GPqffEexEr8T8N9F7TRp?=
 =?Windows-1252?Q?5TWvsKAEmGJ13U6Gd1Ey7PJluMnM/TwVxd7kYwejc1/uZ7FnbK6gXL4a?=
 =?Windows-1252?Q?eH8nCvC9UHqSer+UDqncS1VbCKhjY0SQ4OXsgNGE08gorRCqbMg5CSG+?=
 =?Windows-1252?Q?roeQyULNloXwR+YalatnBafHF7Qdkznh/iPsUp8vfX4f981nmGOCs/mD?=
 =?Windows-1252?Q?FC+v1L7646K8xBnkKC8z/o0iVdoVfpwgV9aEfJ9w4bXjFVtMRmiKfI5E?=
 =?Windows-1252?Q?ZSBiyVEZOXaVTrHuiZnja+MMbweOmbomJXpLuKrvvyFS1vfUhSMnbcH8?=
 =?Windows-1252?Q?WVh/lztQ+PKf0/+JXIbr67lEPJ/PvvzOvHVdLJWylV5H0hLbbqQPUf1G?=
 =?Windows-1252?Q?9zzpBXL1KgrTdcFdX1WP2YAOhw0iCREjeq1RqgPUEeAJ0cPBd+5Z+J90?=
 =?Windows-1252?Q?k7CI/XNnK5HznHYClxNY05ti3kGNwUb3cvmr2ZW9pHh1vyiNf0sbAQyh?=
 =?Windows-1252?Q?I3A9qZvOO5LiBSU4HyVMNNdMAAH3x+V3HGD2qlbaxpEMT2R06W5gTx38?=
 =?Windows-1252?Q?rSxOutHNB1WKPWplH+gIWdwKE0xB7+zYhKYjEcOx4kEZHe8yyDGKsZC/?=
 =?Windows-1252?Q?bx8G0q3LmTaZ6Jl72H+JaVOcNX0XyYiDvWspvUB8eQSsyI18QCckTFdM?=
 =?Windows-1252?Q?Xxsf8EEMQTtEf7TW92UiGszzLLeXb9aauKUk+vi9Ry0AaunP7jEqCsgZ?=
 =?Windows-1252?Q?UN4wTxnIahBQdwXPkKun7ivMOcr+Lmc0Xvs=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1157.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 279e7284-7d7e-4480-7369-08dd7151c727
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 19:17:00.3702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1972

Hi ,
=A0
Just wanted to make sure you saw my previous email and have you had a chanc=
e to read it yet?
=A0
Let me know if you=92d like a comprehensive overview of the figures and pri=
cing.
=A0
Regards
Lexie Hewitt
Demand Generation Manager
B2B Leads LP Inc.,
=A0
Please reply with REMOVE if you don=92t wish to receive further emails
=A0
-----Original Message-----
From: Lexie Hewitt
To:=20
Subject: ProMat 2025 Attendees Database =96 Expand Your Reach
=A0
Hi ,
=A0
Have you thought about obtaining the ProMat 2025 attendee list?
=A0
=A0Expo Name: ProMat Expo 2025
=A0Total Number of records: 35,000 records
=A0List includes: Company Name, Contact Name, Job Title, Mailing Address, P=
hone, Emails, etc.
=A0
Are you thinking about purchasing these leads? I can provide the pricing de=
tails.
=A0
Awaiting your comments
=A0
Regards
Lexie Hewitt
Demand Generation Manager
B2B Leads LP Inc.,
=A0
Please reply with REMOVE if you don=92t wish to receive further emails
