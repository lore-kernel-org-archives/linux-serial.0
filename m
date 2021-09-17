Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,URIBL_PH_SURBL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E03C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 17 Sep 2021 11:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424756120D
	for <linux-serial@archiver.kernel.org>; Fri, 17 Sep 2021 11:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343976AbhIQL3m (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Sep 2021 07:29:42 -0400
Received: from 186.250.87.110.broad.sm.fj.dynamic.163data.com.cn ([110.87.250.186]:51081
        "EHLO kh54hq.top" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1343959AbhIQL3l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Sep 2021 07:29:41 -0400
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 07:29:41 EDT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=kh54hq.top;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=service@kh54hq.top;
 bh=Gwm2kJJjViBAk+kbJ2v7afcn97E=;
 b=gsatfE8i0CUcaPnO+jvxbasL7mTXTND5pan70ShmhAkw1joSokD7RtmRxXT9er8aoDUX3UklVWoF
   YG08rGqzCI69tGMMAvH+Tj1BIDH9IuYRLSl2InPt2SUIyPKJVKGJttUpomTG0lFJdjxtJJMlgOD3
   eSePLPEh6Q66xFghG48=
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=kh54hq.top;
 b=Ozs0aSFqkXwIFKRG8eSd3TJVPxNqo9plU5HVTmghggmcz6/KGL/t3xugGAu0+/BmGrH+s2ghuweU
   Uty48VMWNXGmYULMql1lpilerHTNQjI1/SM6xASgegNLWOt+jdEezVWLfvmmhp7HNYCcjDZ4R+XJ
   We/IzFALwoYKZ6gTrsQ=;
Message-ID: <20210917190720526238@kh54hq.top>
From:   =?utf-8?B?77yl77y077yj44K144O844OT44K544Gu44GK55+l44KJ44Gb?= 
        <service@kh54hq.top>
To:     <linux-serial@vger.kernel.org>
Subject: =?utf-8?B?RVRD44K144O844OT44K544KS44GU5Yip55So44Gu44GK5a6i5qeY?=
Date:   Fri, 17 Sep 2021 19:07:10 +0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-mailer: Acts 3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RVRD44K144O844OT44K544KS44GU5Yip55So44Gu44GK5a6i5qeYOg0KDQpFVEPjgrXjg7zjg5Pj
grnjga/nhKHlirnjgavjgarjgorjgb7jgZfjgZ/jgIINCuW8leOBjee2muOBjeOCteODvOODk+OC
ueOCkuOBlOWIqeeUqOOBhOOBn+OBoOOBjeOBn+OBhOWgtOWQiOOBr+OAgeS4i+iomOODquODs+OC
r+OCiOOCiuips+e0sOOCkuOBlOeiuuiqjeOBj+OBoOOBleOBhOOAgg0KDQrkuIvoqJjjga7mjqXn
tprjgYvjgonlgZzmraLljp/lm6DjgpLnorroqo3jgZfjgabjgY/jgaDjgZXjgYQNCg0KaHR0cHM6
Ly9ldGMtbWVpc2FpLmpwLnRuLWluZm8udG9wDQoNCijnm7TmjqXjgqLjgq/jgrvjgrnjgafjgY3j
garjgYTloLTlkIjjga/jgIHmiYvli5Xjgafjg5bjg6njgqbjgrbjgavjgrPjg5Tjg7zjgZfjgabp
lovjgYTjgabjgY/jgaDjgZXjgYQpDQoNCuKAu+OBk+OBruODoeODvOODq+OBr+mAgeS/oeWwgueU
qOOBp+OBmeOAgg0K44CA44GT44Gu44Ki44OJ44Os44K544Gr6YCB5L+h44GE44Gf44Gg44GE44Gm
44KC6L+U5L+h44GE44Gf44GX44GL44Gt44G+44GZ44Gu44Gn44CB44GC44KJ44GL44GY44KB44GU
5LqG5om/6aGY44GE44G+44GZ44CCDQrigLvjgarjgYrjgIHjgZTkuI3mmI7jgarngrnjgavjgaTj
gY3jgb7jgZfjgabjga/jgIHjgYrmiYvmlbDjgafjgZnjgYzjgIENCiAgRVRD44K144O844OT44K5
5LqL5YuZ5bGA44Gr44GK5ZWP44GE5ZCI44KP44Gb44GP44Gg44GV44GE44CCDQoNCuKWoEVUQ+WI
qeeUqOeFp+S8muOCteODvOODk+OCueS6i+WLmeWxgA0K5bm05Lit54Sh5LyR44CAOTowMO+9njE4
OjAwDQrjg4rjg5Pjg4DjgqTjg6Tjg6vjgIAwNTcwLTAxMDEzOQ0K77yI44OK44OT44OA44Kk44Ok
44Or44GM44GU5Yip55So44GE44Gf44Gg44GR44Gq44GE44GK5a6i44GV44G+44CAMDQ1LTc0NC0x
Mzcy77yJDQowNDUtNzQ0LTYyOQ==


