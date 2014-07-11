From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: add 32-bit register interface
 support
Date: Fri, 11 Jul 2014 02:38:00 +0000
Message-ID: <d2f73b90bc714108a9aa14824633b375@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1404204226-24452-1-git-send-email-jingchang.lu@freescale.com>
 <20140710230353.GA25661@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1lp0141.outbound.protection.outlook.com ([207.46.163.141]:34494
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751867AbaGKCiE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Jul 2014 22:38:04 -0400
In-Reply-To: <20140710230353.GA25661@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogR3JlZyBLSCBbbWFpbHRvOmdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnXQ0KPlNlbnQ6IEZyaWRheSwgSnVseSAxMSwgMjAxNCA3OjA0
IEFNDQo+VG86IEx1IEppbmdjaGFuZy1CMzUwODMNCj5DYzogbGludXgtc2VyaWFsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+U3ViamVjdDog
UmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IGFkZCAzMi1iaXQgcmVnaXN0ZXIN
Cj5pbnRlcmZhY2Ugc3VwcG9ydA0KPg0KPk9uIFR1ZSwgSnVsIDAxLCAyMDE0IGF0IDA0OjQzOjQ2
UE0gKzA4MDAsIEppbmdjaGFuZyBMdSB3cm90ZToNCj4+IFRoaXMgYWRkIHRoZSBiaWctZW5kaWFu
IDMyLWJpdCByZWdpc3RlciB2ZXJzaW9uIExQVUFSVCBzdXBwb3J0Lg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEppbmdjaGFuZyBMdSA8amluZ2NoYW5nLmx1QGZyZWVzY2FsZS5jb20+DQo+PiAtLS0N
Cj4+ICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIHwgNjUyDQo+PiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDY0MyBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPg0KPlRoaXMgcGF0Y2ggZmFpbHMgdG8gYXBw
bHkgdG8gbXkgdHJlZSA6KA0KPg0KPkNhbiB5b3UgcmVmcmVzaCBpdCBhZ2FpbnN0IHRoZSB0dHkt
bmV4dCBicmFuY2ggb2YgdGhlIHR0eS5naXQgdHJlZSBvbg0KPmdpdC5rZXJuZWwub3JnIGFuZCBy
ZXNlbmQ/DQpZZXMsIEkgd2lsbCBkbyB0aGF0IGFuZCByZXNlbmQgdGhlIHBhdGNoLiBUaGFua3Mu
DQoNCg0KDQpCZXN0IFJlZ2FyZHMsDQpKaW5nY2hhbmcNCg0KDQoNCg0KDQo=
