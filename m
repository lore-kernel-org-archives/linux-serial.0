Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD898C636C9
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 23:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E234611C1
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 23:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355101AbhGSW7A (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:59:00 -0400
Received: from [111.225.152.182] ([111.225.152.182]:59477 "EHLO 1mdnx.top"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1386343AbhGSUUo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Jul 2021 16:20:44 -0400
X-Greylist: delayed 1242 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jul 2021 16:20:43 EDT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=1mdnx; d=1mdnx.top;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=etc-melsal@1mdnx.top;
 bh=kEUPzTL+C23utVXXiQS60gcolvM=;
 b=PB1lP6BgtUk3R+mTv/ng5L4pVjkV8U1BQz4ymx5/0hQ5xzxYZVH2du5R7TpHM6BCcQDahcpR8BKn
   NQoE8Qmi6wecrwjpmQWK2ag95Kj1B8Ny9gAQbyELFyU7LEXrOvl2iwbDnNbJY7SLX3Qe8lNaoGg1
   iy+cb+WQZcLqTpZMNos=
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=1mdnx; d=1mdnx.top;
 b=Nd7qpWC4EEdwuoZw2uw5djdhW0jdiCiMFNS48fxE72kj/640VuGVLkpXPKZAkdJzjjyWKR7HK4Z6
   gVRbBqt6oPwb8EyQ32sBAu0m3P6t6XjOPSjpU5/VwCu+CqN646dCV39CYKqUHNbDjmJ5YT8Pd4M8
   UxolHqnDJnyisxKGspA=;
Message-ID: <F60E503B59F6CE5D218EEE191E3C10B2@wcicuf>
From:   =?utf-8?B?RVRD5oOF5aCx?= <etc-melsal@1mdnx.top>
To:     <linux-serial@vger.kernel.org>
Subject: =?utf-8?B?44K144O844OT44K56YCa55+l?=
Date:   Tue, 20 Jul 2021 04:39:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RVRD44K144O844OT44K544KS44GU5Yip55So44Gu44GK5a6i5qeYOg0KDQoNCkVUQ+OCteODvOOD
k+OCueOBr+eEoeWKueOBq+OBquOCiuOBvuOBl+OBn+OAgg0K5byV44GN57aa44GN44K144O844OT
44K544KS44GU5Yip55So44GE44Gf44Gg44GN44Gf44GE5aC05ZCI44Gv44CB5LiL6KiY44Oq44Oz
44Kv44KI44KK6Kmz57Sw44KS44GU56K66KqN44GP44Gg44GV44GE44CCDQoNCg0K5LiL6KiY44Gu
5o6l57aa44GL44KJ5YGc5q2i5Y6f5Zug44KS56K66KqN44GX44Gm44GP44Gg44GV44GEDQpodHRw
czovL2V0Yy1tc2xmYWktanAucmFkaW8uYW0NCg0KKOebtOaOpeOCouOCr+OCu+OCueOBp+OBjeOB
quOBhOWgtOWQiOOBr+OAgeaJi+WLleOBp+ODluODqeOCpuOCtuOBq+OCs+ODlOODvOOBl+OBpumW
i+OBhOOBpuOBj+OBoOOBleOBhCkNCg0KDQoNCuKAu+OBk+OBruODoeODvOODq+OBr+mAgeS/oeWw
gueUqOOBp+OBmeOAgg0K44CA44GT44Gu44Ki44OJ44Os44K544Gr6YCB5L+h44GE44Gf44Gg44GE
44Gm44KC6L+U5L+h44GE44Gf44GX44GL44Gt44G+44GZ44Gu44Gn44CB44GC44KJ44GL44GY44KB
44GU5LqG5om/6aGY44GE44G+44GZ44CCDQrigLvjgarjgYrjgIHjgZTkuI3mmI7jgarngrnjgavj
gaTjgY3jgb7jgZfjgabjga/jgIHjgYrmiYvmlbDjgafjgZnjgYzjgIENCsOLVEPjgrXjg7zjg5Pj
grnkuovli5nlsYDjgavjgYrllY/jgYTlkIjjgo/jgZvjgY/jgaDjgZXjgYTjgIINCg0KDQoNCuKW
oEVUQ+WIqeeUqOeFp+S8muOCteODvOODk+OCueS6i+WLmeWxgA0K5bm05Lit54Sh5LyR44CAOTow
MO+9njE4OjAwDQrjg4rjg5Pjg4DjgqTjg6Tjg6vjgIAwNTcwLTAxMDEzOQ0K77yI44OK44OT44OA
44Kk44Ok44Or44GM44GU5Yip55So44GE44Gf44Gg44GR44Gq44GE44GK5a6i44GV44G+44CAMDQ1
LTc0NC0xMzcy77yJDQo=


